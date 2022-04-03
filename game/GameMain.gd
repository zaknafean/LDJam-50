extends Node2D

const livingRoom = preload("res://levels/rooms/LivingRoom.tscn")
const bathRoom = preload("res://levels/rooms/BathRoom.tscn")
const kitchenRoom = preload("res://levels/rooms/KitchenRoom.tscn")
const bedRoom = preload("res://levels/rooms/BedRoom.tscn")
const unknownRoom = preload("res://levels/rooms/UnknownRoom.tscn")
const unlikedRoom = preload("res://levels/rooms/UnlikedRoom.tscn")

var curRoomString
var curRoom : BaseRoom

# Called when the node enters the scene tree for the first time.
func _ready():
		# Connect Signals
	if SignalMngr.connect("game_started", self, "_on_game_started") != OK:
		D.e("Game", ["Signal game_started is already connected"])
	if SignalMngr.connect("restart_level", self, "restart_level") != OK:
		D.e("Game", ["Signal restart_level is already connected"])
	if SignalMngr.connect("next_level", self, "next_level")!= OK:
		D.e("Game", ["Signal next_level is already connected"])
		
	start_level()


func start_level():
	#StateMngr.score.state = 0
	if curRoom:
		remove_child(curRoom)
		curRoom.queue_free()
	curRoom = livingRoom.instance()
	curRoomString = 'living'
	if StateMngr.start_level_id == 1:
		pass
	add_child(curRoom)
	yield(get_tree(), "idle_frame")
	curRoom._set_spawns('s')


func change_room(newRoom: String, directionFrom: String, _delay=2):
	var doorLocation
	if directionFrom == 'w':
		doorLocation = curRoom.get_node("Interactables/DoorWestClickable").interactionPosition
	if directionFrom == 'e':
		doorLocation = curRoom.get_node("Interactables/DoorEastClickable").interactionPosition
	if directionFrom == 'n':
		doorLocation = curRoom.get_node("Interactables/DoorSouthClickable").interactionPosition
	if directionFrom == 's':
		doorLocation = curRoom.get_node("Interactables/DoorNorthClickable").interactionPosition
	
	var timeToDoor = doorLocation.distance_to(curRoom.enemy.global_position) / curRoom.enemy.SPEED
	var newDelay = clamp(timeToDoor, 1, 25)
	
	if curRoomString == newRoom:
		print('error you went in a loop somehow')
		return
	
	if curRoom:
		remove_child(curRoom)
		curRoom.queue_free()
	else:
		print("Error: curRoom doesn't exist whith shouldn't be possible")
		return
	
	if newRoom == 'living':
		curRoom = livingRoom.instance()
	elif newRoom == 'bath':
		curRoom = bathRoom.instance()
	elif newRoom == 'bed':
		curRoom = bedRoom.instance()
	elif newRoom == 'kitchen':
		curRoom = kitchenRoom.instance()
	elif newRoom == 'unknown':
		curRoom = unknownRoom.instance()
	elif newRoom == 'unliked':
		curRoom = unlikedRoom.instance()
	
	curRoomString = newRoom
	add_child(curRoom)
	yield(get_tree(), "idle_frame")
	curRoom._set_spawns(directionFrom, newDelay)


func _on_game_started():
	start_level()
	
func restart_level():
	start_level()

func next_level():
	start_level()

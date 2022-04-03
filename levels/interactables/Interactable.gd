extends Area2D

class_name Interactable

onready var interactionPosition = $InteractionPosition.global_position setget ,interactionPositionGet
onready var sprite = $Sprite

export (bool) var canHighlight = false
export (bool) var canClick = false
export (bool) var reroute_after_dialog = false
export (String, 'default', 'up', 'down', 'left', 'right') var facing_direction = 'default'
export (bool) var isOneShot = false

var canRun = true
var antiSpam = false
var myEvents

# warning-ignore:unused_signal
signal reroute_player
signal events_done


func _ready():
	myEvents = $EventQueue.get_children()
	setup()


func setup():
	pass


func runEvent():
	if antiSpam:
		return
	
	for event in myEvents:
		if event.difficulty == Settings.difficulty or event.difficulty == -1:
			if event.event_type == Settings.EVENTS.DIALOG:
				Settings.curGameState = Settings.GAME_STATES.DIALOG
				var new_dialog = Dialogic.start(event.DIALOG)
				add_child(new_dialog)
				new_dialog.connect("dialogic_signal", self, 'signal_router')
				new_dialog.connect('timeline_end', self, 'after_dialog')
				antiSpam = true
		
	emit_signal("events_done")

func interactionPositionGet():
	return $InteractionPosition.global_position


func after_dialog(_timeline_name):
	Settings.curGameState = Settings.GAME_STATES.PLAY
	if isOneShot:
		queue_free()
	else:
		unlockAntiSpan()


func signal_router(inputString):
	var tokenizedArray = inputString.split(',')
	
	if tokenizedArray[0] == 'setflag':
		if get_parent().get_parent().has_method('_on_Area2D_mouse_entered'):
			Settings.locationData.curMeatScene = get_parent().get_parent().filename
			Settings.locationData.curMeatPosition = get_parent().get_parent().get_node('Player').global_position
			Settings.locationData.curMeatMusic = get_parent().get_parent().bgm_music
		
		var quest = int(tokenizedArray[1])
		var value = int(tokenizedArray[2])
		Settings.setFlag(quest, value)
	
	if tokenizedArray[0] == 'anim':
		var animation = tokenizedArray[1]
		var speed = int(tokenizedArray[2])
		# TODO double get_parent
		get_parent().get_parent().get_node("SetpieceAnimation").play(animation, -1, speed)
	
	if tokenizedArray[0] == 'endlevel':
		if get_parent().get_parent().has_method('_on_Area2D_mouse_entered'):
			Settings.locationData.curMeatScene = get_parent().get_parent().filename
			Settings.locationData.curMeatPosition = get_parent().get_parent().get_node('Player').global_position
			Settings.locationData.curMeatMusic = get_parent().get_parent().bgm_music
		Settings.save_data()
		get_parent().get_parent()._on_level_complete()
	
	if tokenizedArray[0] == 'save':
		Settings.locationData.curMeatScene = get_parent().get_parent().filename
		Settings.locationData.curMeatPosition = get_parent().get_parent().get_node('Player').global_position
		Settings.locationData.curMeatMusic = get_parent().get_parent().bgm_music
		Settings.save_data()


func unlockAntiSpan():
	if antiSpam:
		yield(get_tree().create_timer(.9), "timeout")
	antiSpam = false

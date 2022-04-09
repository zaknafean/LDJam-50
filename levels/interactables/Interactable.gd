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
signal interaction_complete


func _ready():
	myEvents = $EventQueue.get_children()
	setup()


func setup():
	pass


func runEvent():
	if antiSpam:
		return
	myEvents = $EventQueue.get_children()
	var curDifficulty = Settings.difficulty
	for event in myEvents:
		if event.difficulty == curDifficulty or event.difficulty == -1:
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
	emit_signal('interaction_complete')


func signal_router(inputString):
	var tokenizedArray = inputString.split(',')
	if tokenizedArray[0] == 'TVOn':
		$AnimationPlayer.play('TVOn')
		$EventQueue.get_child(0).queue_free()


func unlockAntiSpan():
	if antiSpam:
		yield(get_tree().create_timer(.9), "timeout")
	antiSpam = false


extends KinematicBody2D


var playerRef
var delayTimer
var eatTimer
var VELOCITY
var SPEED = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_parent().get_node('Player')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Settings.curGameState == Settings.GAME_STATES.PLAY:
		VELOCITY = (playerRef.position - position).normalized() * SPEED
		var _collision = move_and_slide(VELOCITY)

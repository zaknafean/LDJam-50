extends KinematicBody2D

onready var eatTimer := $EatTimer

var playerRef
var delayTimer
var VELOCITY
var SPEED = 25

var amEating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_parent().get_node('Player')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Settings.curGameState == Settings.GAME_STATES.PLAY and !amEating:
		VELOCITY = (playerRef.position - position).normalized() * SPEED
		var _collision = move_and_slide(VELOCITY)


func _on_Hit_Box_body_entered(body):
	if body.name == "Player" and !amEating:
		print("EATING")
		Settings.adjust_sanity(-25)
		eatTimer.start()
		amEating = true


func _on_EatTimer_timeout():
	amEating = false

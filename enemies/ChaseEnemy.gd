extends KinematicBody2D

onready var eatTimer := $EatTimer
onready var anim := $AnimationPlayer

var playerRef
var delayTimer
var VELOCITY
var SPEED := 25.0
var curSpeed := 25.0

var amEating = false
var amActive = false

var sprite_dir = "right"			#where we are actually facing. A string for anim
var facing_dir = Vector2.DOWN	#where we are facing in vector notation
var move_dir = Vector2.ZERO		#where we want to go


# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_parent().get_node('Player')
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Settings.curGameState == Settings.GAME_STATES.PLAY or Settings.curGameState == Settings.GAME_STATES.BATTLE or Settings.curGameState == Settings.GAME_STATES.DIALOG) and !amEating and amActive:
		
		if Settings.curGameState == Settings.GAME_STATES.BATTLE or Settings.curGameState == Settings.GAME_STATES.DIALOG:
			curSpeed = (SPEED + (Settings.roomsExplored * 3)) / 3
		else: 
			curSpeed = SPEED + (Settings.roomsExplored * 3)
		VELOCITY = (playerRef.position - position).normalized() * curSpeed
		var _collision = move_and_slide(VELOCITY)
		var walk_dir = VELOCITY.normalized()
		#print(walk_dir)
		if abs(walk_dir.y) > abs(walk_dir.x):
			if walk_dir.y > 0:
				#sprite_dir = "down"
				pass
			else:
				#sprite_dir = "up"
				pass
		else:
			if walk_dir.x > 0:
				sprite_dir = "right"
			else:
				sprite_dir = "left"
		
		anim_switch('run', 1)


func activate(delay: int):
	yield(get_tree().create_timer(delay), "timeout")
	amActive = true
	curSpeed = SPEED + (Settings.roomsExplored * 3)
	show()
	#Particle effects and shizzle go here


func anim_switch(animation, speed = 1):
	var newanim = str(animation,'_',sprite_dir)
	if anim.current_animation != newanim:
		anim.play(newanim, -1, speed)


func _on_Hit_Box_body_entered(body):
	if body.name == "Player" and !amEating and amActive:

		body.taking_damage = true

		Settings.adjust_sanity(-25)
		eatTimer.start()
		amEating = true


func _on_EatTimer_timeout():
	amEating = false

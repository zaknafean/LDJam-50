extends KinematicBody2D


export var SPEED = 250
var margin = 1

var path : = PoolVector2Array()
onready var anim = $AnimationPlayer
onready var dangerNoise = $DangerSound

var sprite_dir = "down"			#where we are actually facing. A string for anim
var facing_dir = Vector2.DOWN	#where we are facing in vector notation
var move_dir = Vector2.ZERO		#where we want to go
var taking_damage = false

signal arrived


func _process(delta):
	if Settings.sanityValue < 25:
		dangerNoise.volume_db = 15
		if dangerNoise.playing == false:
			dangerNoise.play()
	elif Settings.sanityValue < 50:
		dangerNoise.volume_db = 0
		if dangerNoise.playing == false:
			dangerNoise.play()
	elif Settings.sanityValue < 75:
		dangerNoise.volume_db = -15
		if dangerNoise.playing == false:
			dangerNoise.play()
	
	# Calculate the movement distance for this frame
	var distance_to_walk = SPEED * delta
	if taking_damage and (!anim.current_animation =='hit_left' or anim.current_animation =='hit_right'):
		anim_switch('hit', 1)
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		var walk_dir = position.direction_to(path[0])
		
		if walk_dir.x > 0:
			sprite_dir = "right"
		else:
			sprite_dir = "left"
	
		anim_switch('walk', 1)
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]

			path.remove(0)
			
			if path.empty():
				anim_switch("idle", .5)
				emit_signal("arrived")
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	
	if Settings.alertnessValue > 0 and path.size() == 0:
		Settings.alertnessValue -= delta * 5
	elif Settings.alertnessValue > 0:
		Settings.alertnessValue -= delta * 1


func anim_switch(animation, speed = 1):
	if taking_damage:
		anim.play(str('hit_',sprite_dir), -1, speed)
		return
	var newanim = str(animation,'_',sprite_dir)
	if anim.current_animation != newanim:
		anim.play(newanim, -1, speed)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'hit_right' or anim_name == 'hit_left':
		taking_damage = false
		anim_switch("idle", .5)

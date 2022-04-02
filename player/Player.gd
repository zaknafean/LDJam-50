extends KinematicBody2D


export var SPEED = 250
var margin = 1

var path : = PoolVector2Array()
onready var anim = $AnimationPlayer

var sprite_dir = "down"			#where we are actually facing. A string for anim
var facing_dir = Vector2.DOWN	#where we are facing in vector notation
var move_dir = Vector2.ZERO		#where we want to go


signal arrived


func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = SPEED * delta
	
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		var walk_dir = position.direction_to(path[0])
		
		if abs(walk_dir.y) > abs(walk_dir.x):
			if walk_dir.y > 0:
				sprite_dir = "down"
			else:
				sprite_dir = "up"
		else:
			if walk_dir.x > 0:
				sprite_dir = "right"
			else:
				sprite_dir = "left"
		
		#anim_switch('walk', 1)
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]

			path.remove(0)
			
			if path.empty():
				#anim_switch("idle", .5)
				emit_signal("arrived")
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	
	if Settings.tiredValue > 0 and path.size() == 0:
		Settings.tiredValue -= delta * 5
	elif Settings.tiredValue > 0:
		Settings.tiredValue -= delta * 1
	print('Tired: ',Settings.tiredValue)

func anim_switch(animation, speed = 1):
	var newanim = str(animation,'_',sprite_dir)
	if anim.current_animation != newanim:
		anim.play(newanim, -1, speed)

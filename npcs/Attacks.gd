extends Node2D

#onready var pivot = get_parent().get_node_or_null('Target_Locations')

export var rotation_speed = .45

func _onready():
	pass

#func _process(delta):
#	self.rotation += rotation_speed * delta

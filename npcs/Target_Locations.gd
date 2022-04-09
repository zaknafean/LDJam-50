extends Node2D

var rotation_speed = 2


func _process(delta):
	self.rotation += rotation_speed * delta

extends Node2D

var rotation_speed = 1.5


func _process(delta):
	self.rotation += rotation_speed * delta

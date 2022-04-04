extends Node2D

var FcT = preload('res://levels/floatingtext/Floating_Text.tscn')

export var travel = Vector2(0, -80)
export var duration = 3
export var spread = 7.5

func show_value(value, type):
	var fct = FcT.instance()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, type)

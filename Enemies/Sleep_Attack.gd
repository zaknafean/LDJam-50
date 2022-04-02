extends Node2D

export var Can_Click :bool

func _ready():
	pass

func _unhandled_input(event):
	if event.is_echo():
		return

	if event.is_action_pressed("ui_primaryclick") and Can_Click == true:
		queue_free()
		return

func _on_Area2D_mouse_entered():
	Can_Click = true

func _on_Area2D_mouse_exited():
	Can_Click = false

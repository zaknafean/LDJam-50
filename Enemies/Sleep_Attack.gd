extends Node2D

onready var tween = $Tween

export var Can_Click :bool

func _ready():
	pass

func _unhandled_input(event):
	if event.is_echo():
		return

	if event.is_action_pressed("ui_primaryclick") and Can_Click == true:
		$CPUParticles2D.emitting = true
		tween.connect("tween_all_completed", self, '_on_tween_all_completed')
		tween.interpolate_property(self, "scale", self.scale, Vector2(0,0), 1.25, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees, 355, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func _on_tween_all_completed():
	queue_free()


func _on_Area2D_mouse_entered():
	Can_Click = true

func _on_Area2D_mouse_exited():
	Can_Click = false

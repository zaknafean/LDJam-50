extends Node2D

class_name Event

export (Settings.EVENTS) var event_type = Settings.EVENTS.DIALOG
export (int) var difficulty = 1


func _ready():
	setup()


func setup():
	pass


func runEvent():
	print('Base Event. It does nothing.')

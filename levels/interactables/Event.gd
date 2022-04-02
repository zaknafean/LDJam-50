extends Node2D

class_name Event


export (Settings.EVENTS) var event_type = Settings.EVENTS.DIALOG
export (int) var quest_id = -1
export (int) var quest_value = -1

func _ready():
	setup()


func setup():
	pass


func runEvent():
	print('Base Event. It does nothing.')

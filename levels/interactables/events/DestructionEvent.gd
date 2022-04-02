extends Event

signal Die

func _ready():
	setup()

func setup():
	pass 

func runEvent():
	emit_signal('Die')
	print('Base Event. It does nothing.')

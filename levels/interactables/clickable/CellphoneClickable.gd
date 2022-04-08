extends SpriteClickable


# Called when the node enters the scene tree for the first time.
func setup():
	randomize()
	var ranVal = randi() % 8 + 1
	var timelineName = str('random-work-',ranVal)

	$EventQueue/DialogEvent.DIALOG = timelineName

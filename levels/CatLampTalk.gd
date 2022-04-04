extends SpriteClickable


func setup():
	randomize()
	var whichCat = randi() % 3 + 1
	if whichCat < 3:
		$Sprite.visible = true
	else:
		queue_free()
		return
	
	if Settings.firstCat == false:
		$EventQueue/DialogEvent.DIALOG = 'Friendly? Cat'
		Settings.firstCat = true
	else:
		randomize()
	
		var ranVal = randi() % 3 +1
		var timelineName = str('D',Settings.difficulty,' R',ranVal)
		$EventQueue/DialogEvent.DIALOG = timelineName


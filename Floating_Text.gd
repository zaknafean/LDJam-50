extends Position2D

func show_value(value, travel, duration, spread):
	randomize()
	
	$Label.text = value
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	$Label.rect_pivot_offset = $Label.rect_size / 2
	
	$Tween.interpolate_property($Label, 'rect_position', $Label.rect_position, $Label.rect_position + movement, duration, Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Label, 'modulate:a', 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()

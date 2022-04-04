extends Position2D

func show_value(value, travel, duration, spread, type):
	randomize()
	
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	$Label.rect_pivot_offset = $Label.rect_size / 2
	
	$Tween.interpolate_property($Label, 'rect_position', $Label.rect_position, $Label.rect_position + movement, duration, Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Label, 'modulate:a', 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if type == 0:
		$Label.text = value + ' Score'
		$Label.add_color_override("font_color", Color (0.8, .6, .25)) 
		$Tween.interpolate_property($Label, 'rect_scale', $Label.rect_scale*1.5, $Label.rect_scale*3, 0.4, Tween.TRANS_BACK, Tween.EASE_IN)
	if type == 1:
		$Label.text = value + ' Alert'
		$Label.add_color_override("font_color", Color (.65, .2, .2))
		$Tween.interpolate_property($Label, 'rect_scale', $Label.rect_scale*2, $Label.rect_scale, 0.4, Tween.TRANS_BACK, Tween.EASE_IN)
	if type == 2:
		$Label.text = value + ' Sanity'
		$Label.add_color_override("font_color", Color (.75, .3, .6))
	
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()

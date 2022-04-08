extends Position2D

onready var label = $Label
onready var tween = $Tween

func show_value(value, travel, duration, spread, type):
	randomize()
	
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	label.rect_pivot_offset = label.rect_size / 2
	
	tween.interpolate_property(label, 'rect_position', label.rect_position, label.rect_position + movement, duration, Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	tween.interpolate_property(label, 'modulate:a', 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if type == 0:
		label.text = value + ' Score'
		label.add_color_override("font_color", Color (0.8, .6, .25)) 
		tween.interpolate_property(label, 'rect_scale', label.rect_scale*1.5, label.rect_scale*3, 0.4, Tween.TRANS_BACK, Tween.EASE_IN)
	if type == 1:
		label.text = value + ' Alert'
		label.add_color_override("font_color", Color (.65, .2, .2))
		tween.interpolate_property(label, 'rect_scale', label.rect_scale*2, label.rect_scale, 0.4, Tween.TRANS_BACK, Tween.EASE_IN)
	if type == 2:
		label.text = value + ' Sanity'
		label.add_color_override("font_color", Color (.75, .3, .6))
	
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()

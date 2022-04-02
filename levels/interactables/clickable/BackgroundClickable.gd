extends Interactable
#
#	A clickable event for things that don't have a unique sprite. 
#	You click the background which hopefully has an image built in.
#
class_name BackgroundClickable, "res://assets/icons/button-finger.png"

# Called when the node enters the scene tree for the first time.
func setup():
	# Assuming the area has a child CollisionShape2D with a RectangleShape resource
	var area_size = $CollisionShape2D.shape.extents * 2.0

	# The size of a sprite is determined from its texture
	var texture_size = sprite.texture.get_size()

	# Calculate which scale the sprite should have to match the size of the area
	var sx = area_size.x / texture_size.x
	var sy = area_size.y / texture_size.y

	sprite.scale = Vector2(sx, sy)
	sprite.global_position = $CollisionShape2D.global_position

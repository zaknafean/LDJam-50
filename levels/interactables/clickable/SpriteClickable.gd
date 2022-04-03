extends Interactable

#
#	A clickable event for things that do have a unique sprite. 
#	Whatever this is probably has a sprite layered over the background
#

class_name SpriteClickable, "res://assets/icons/person.png"


# Called when the node enters the scene tree for the first time.
func setup():
	if get_node_or_null('AnimationPlayer'):
		#$AnimationPlayer.play("idle")
		pass

extends Interactable

class_name BackgroundCollidable, "res://assets/icons/foot-plaster.png"
export (bool) var no_reroute = false


func _on_BackgroundCollidable_body_entered(_body):
	#print(self.get_parent().name, ' collided with ', _body.name)
	for event in myEvents:
		
		if Settings.questCheck(event.quest_id, event.quest_value):
			if no_reroute:
				runEvent()
			else:
				emit_signal("reroute_player", self, true)
			break
	


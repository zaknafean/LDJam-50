extends PopupPanel

onready var message = $MarginContainer/VBoxContainer/Panel/StatusMessage
onready var score = $MarginContainer/VBoxContainer/ScoreLabel
onready var initialInput = $MarginContainer/VBoxContainer/InitialsInput

func _on_CloseButton_pressed():
	hide()


# Actually sends the score to the server
func _on_SubmitScoreButton_pressed():
	
	var initials = initialInput.text
	message.visible = false
	
	if initials.length() < 1:
		var newMessage = str("[center][color=red][shake rate=5 level=5]Please Enter Initials!![/shake][/color][/center]")
		message.visible = true
		message.bbcode_text = newMessage
		return
		
	initials = initials.to_lower()
	if is_blacklisted(initials):
		var newMessage = str("[center][color=red]Illegal or inappropriate initials!![/color][/center]")
		message.visible = true
		message.bbcode_text = newMessage
		return
		
	#var name = str(initials, ':',Settings.my_id)
	
	var metadata = {
		"name": str(initials)
	}
	
	var newScore = Settings.trueScore
	get_tree().paused = false
	var _score_id = yield(SilentWolf.Scores.persist_score(Settings.my_id, newScore, 'main', metadata), "sw_score_posted")
	
	yield(SilentWolf.Scores.get_score_position(newScore, 'main'), "sw_position_received")
	get_tree().paused = true
	var position = SilentWolf.Scores.position
	var newMessage = str("[center][color=red]Sorry unknown error has occured![/color][/center]")
	if position > 0:
		newMessage = str("[center][color=green]Score recieved successfully\nYour rank would be ",position,"![/color][/center]")
	message.visible = true
	message.bbcode_text = newMessage
	Settings.lastScoreUpdate = 0
	$MarginContainer/VBoxContainer/SubmitScoreButton.disabled = true
	#scoreSubmitPopup.get_node("MarginContainer/VBoxContainer/InitialsLabel").editable = false
	
	#MarginContainer/VBoxContainer/HBoxContainer/SendScoresButton.disabled = true



func is_blacklisted(name):
	if name == 'ass':
		return true
	if name == 'fag':
		return true
	if name == 'gay':
		return true
	if name == 'sex':
		return true
	return false


func _on_SubmitScorePanel_about_to_show():
	score.bbcode_text = str("[center][color=white]Score![/color][/center]\n[center][color=green]",int(Settings.trueScore),"[/color][/center]")
	get_tree().paused = true


func _on_SubmitScorePanel_popup_hide():
	get_tree().paused = false

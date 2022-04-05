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
		"name": str(initials),
		"time": str(OS.get_unix_time())
	}
	
	var newScore = Settings.score
	get_tree().paused = false
	var _score_id = yield(SilentWolf.Scores.persist_score(Settings.my_id, newScore, 'main', metadata), "sw_score_posted")
	
	yield(SilentWolf.Scores.get_score_position(newScore, 'main'), "sw_position_received")
	get_tree().paused = true
	var position = SilentWolf.Scores.position
	var newMessage = str("[center][color=red]Sorry unknown error has occured![/color][/center]")
	if position > 0:
		newMessage = str("[center][color=green]Score recieved successfully\nEstimated position ",position,"![/color][/center]")
	message.visible = true
	message.bbcode_text = newMessage
	Settings.lastScoreUpdate = 0
	$MarginContainer/VBoxContainer/SubmitScoreButton.disabled = true
	#scoreSubmitPopup.get_node("MarginContainer/VBoxContainer/InitialsLabel").editable = false
	
	#MarginContainer/VBoxContainer/HBoxContainer/SendScoresButton.disabled = true


func _process(_delta):
	score.bbcode_text = str("[center][color=white]Immortalize your work...[/color][/center]\n[center][color=green]",int(Settings.score),"[/color][/center]")


func is_blacklisted(name):
	if name == 'ass':
		return true
	if name == 'fag':
		return true
	if name == 'gay':
		return true
	if name == 'sex':
		return true
	if name == 'a55':
		return true
	if name == 'kkk':
		return true
	if name == 'azz':
		return true
	if name == 'tit':
		return true
	if name == 'bra':
		return true
	if name == 'cok':
		return true
	if name == 'kok':
		return true
	if name == 'c0k':
		return true
	if name == 'k0k':
		return true    
	if name == 'dik':
		return true
	if name == 'd1k':
		return true
	if name == 'fat':
		return true
	if name == 'f4g':
		return true
	if name == 'fuk':
		return true
	if name == 'gey':
		return true
	if name == 'g4y':
		return true
	if name == 'hiv':
		return true
	if name == 'jap':
		return true
	if name == 'jiz':
		return true
	if name == 'lez':
		return true
	if name == 's3x':
		return true
	if name == 'xxx':
		return true
	if name == 'vag':
		return true
	if name == 'wtf':
		return true
	if name == 'wop':
		return true
	return false


func _on_SubmitScorePanel_about_to_show():

	score.bbcode_text = str("[center][color=white]Immortalize your work...[/color][/center]\n[center][color=green]",int(Settings.score),"[/color][/center]")

	#get_tree().paused = true


func _on_SubmitScorePanel_popup_hide():
	#get_tree().paused = false
	pass

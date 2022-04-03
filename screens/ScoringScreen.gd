extends Screen


onready var statusLabel := $MenuLayer/UIBox/VBoxContainer/StatusLabel
onready var scoreList := $MenuLayer/UIBox/VBoxContainer/ScoringPanel/ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_ShowScoresButton_pressed()


# Gets the highscore list from the server
func _on_ShowScoresButton_pressed():
	var leaderboard = "main"
	

	statusLabel.bbcode_text = str("[center][color=yellow]Retrieving Scores from work-central.net[/color][/center]")

	var scores = []
	if SilentWolf.Scores.leaderboards:
		if leaderboard == 'main' and SilentWolf.Scores.leaderboards.has('main'):
			scores = SilentWolf.Scores.leaderboards['main']
	
	if scores.size() == 0 or (OS.get_unix_time() - Settings.lastScoreUpdate > 600):
		yield(get_tree().create_timer(0.1), "timeout")
		yield(SilentWolf.Scores.get_high_scores(10, leaderboard), "sw_scores_received")
		scores = SilentWolf.Scores.scores
		statusLabel.bbcode_text = str("[center][color=green]Showing most recent scores![/color][/center]")
		#print('Got new scores!')
	elif scores.size() != 0:
		statusLabel.bbcode_text = str("[center][color=green]Showing scores![/color][/center]")
	
	if scores.size() == 0:
		statusLabel.bbcode_text = str("[center][color=red]Sorry, Scores unavailable at this time!![/color][/center]")
	
	scoreList.bbcode_text = "[color=white]"
	var counter = 1
	
	for entry in scores:

		var curInitials = 'agy'

		var curScore = 0
		
		if entry.has('metadata'):
			var metaData = entry.metadata
			curInitials = metaData.name
		
		if entry.has('score'):
			curScore = entry.score
		
		var newLine = str(counter,') ', curInitials.to_upper(), ' with ', int(curScore), ' reputation points!')
		scoreList.append_bbcode(newLine)
		if entry.player_name == Settings.my_id:
			scoreList.append_bbcode(str("[color=yellow] <== Your best score[/color]"))
		scoreList.append_bbcode('\n')
		counter = counter + 1


func _on_BtnBack_pressed():
	ScreenMngr.pop_screen()

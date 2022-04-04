extends Node

const UUID = preload("res://addons/silent_wolf/utils/UUID.gd")
var settings_file = "user://sonipathy.save"
var lastScoreUpdate := 0
enum EVENTS {DIALOG, SCENE_CHANGE, ITEM}

enum GAME_STATES {
	PAUSE,
	DIALOG, 
	PLAY,
	LOADING,
	MENU,
	BATTLE,
}

var my_id := ''
var curGameState = GAME_STATES.PLAY

var difficulty = 1
var roomsExplored = 0
var alertnessValue = 1000
var sanityValue = 100
var score = 0

var gameOver = false

func _ready():
	load_settings()
	
	SilentWolf.configure({
		"api_key": "5dSUku8afu1tQfihzvY9Ua3JJE7P6AYS5y9iq60h",
		"game_id": "LD50",
		"game_version": "0.0.1",
		"log_level": 1
	})
	
	# If no id is loaded, get the device id
	if my_id == '':
		my_id = OS.get_unique_id();
		# if no device id, generate an id
		if my_id == '':
			my_id = str('{',UUID.generate_uuid_v4(),'}')
		save_settings()


func new_game():
	alertnessValue = 1000
	sanityValue = 100
	score = 0
	difficulty = 1
	roomsExplored = 0
	gameOver = false


func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(my_id)
	
	f.close()


func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		for x in range(1):
			var curVar = f.get_var()
			if curVar == null:
				continue
			if x == 0:
				my_id = curVar
		f.close()


func adjust_alertness(value: String):
	alertnessValue += int(value)
	print('Alert Adjusted: ', alertnessValue)
	if alertnessValue <= 0 and gameOver == false:
		gameOver = true
		curGameState = GAME_STATES.MENU
		SignalMngr.emit_signal("level_won")


func adjust_sanity(value: String):
	sanityValue += int(value)
	print('Sanity Adjusted: ', sanityValue)
	if sanityValue <= 0 and gameOver == false:
		gameOver = true
		curGameState = GAME_STATES.MENU
		SignalMngr.emit_signal("level_won")


func adjust_score(value: String):
	score += int(value)
	print('Sanity Adjusted: ', score)
	


func _process(delta):
	score += delta
	if roomsExplored >= 3 and roomsExplored < 10:
		difficulty = 2
	elif roomsExplored >= 8:
		difficulty = 3

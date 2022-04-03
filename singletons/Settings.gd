extends Node

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


func _ready():
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


func new_game():
	alertnessValue = 1000
	sanityValue = 100
	score = 0
	difficulty = 1
	roomsExplored = 0


func adjust_alertness(value: String):
	alertnessValue += int(value)
	print('Alert Adjusted: ', alertnessValue)


func adjust_sanity(value: int):
	sanityValue += value
	print('Sanity Adjusted: ', sanityValue)


func _process(delta):
	score += delta
	if roomsExplored >= 3 and roomsExplored < 10:
		difficulty = 2
	elif roomsExplored >= 10:
		difficulty = 3

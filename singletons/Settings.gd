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

var curGameState = GAME_STATES.PLAY

var alertnessValue = 1000
var sanityValue = 100
var score = 0

func _ready():
	pass


func new_game():
	alertnessValue = 1000
	sanityValue = 100
	score = 0


func adjust_alertness(value: int):
	alertnessValue += value
	print('Alert Adjusted: ', alertnessValue)


func adjust_sanity(value: int):
	sanityValue += value
	print('Sanity Adjusted: ', sanityValue)

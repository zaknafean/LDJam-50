extends Node

enum EVENTS {DIALOG, SCENE_CHANGE, ITEM}

enum GAME_STATES {
	PAUSE,
	DIALOG, 
	PLAY,
	LOADING,
	MENU,
}

var curGameState = GAME_STATES.PLAY


func _ready():
	pass

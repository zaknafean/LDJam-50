extends Node


var questFlags = []



func _ready():
	for _n in range(20):
		questFlags.push_back(0)


func questCheck(quest: int, value: int) -> bool:
	# -1,-1 is null in these checks, so always return true
	if quest == -1 and value == -1:
		return true
	elif questFlags[quest] == value:
		return true
		
	return false


func setFlag(quest: int, value: int) -> void:
	questFlags[quest] = value
	print('Flag: ',quest, ' -> ', value)


func _new_game_setup():
	questFlags.clear()

extends Node2D

class_name SleepEnemies

var count = 0

var sleep_attack :NodePath = "res://Enemies/Sleep_Attack.tscn"
var attack_count = 0
var attack_instance
var targets = []
var spot = 0

func _ready():
	count = 5
	randomize()
	$Label.visible = false
	count = count * Settings.difficulty

func _on_Hit_Box_body_entered(body):
	if body is KinematicBody2D and Settings.curGameState != Settings.GAME_STATES.BATTLE:
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		attack_position()

func _on_Hit_Box_body_exited(body):
	$Label.visible = false

func attack_position():
	targets = []
	for i in count:
		var pick
		pick = randi() % count + 1
		var cur_target = get_node('Target_Locations/Position2D'+str(pick))
		targets.append(cur_target)
	$AnimationPlayer.play("Attacking")

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = targets[spot].global_position
	$Attacks.add_child(attack)
	spot = spot + 1


func can_free_player():
	if $Attacks.get_child_count() == 0:
		Settings.curGameState = Settings.GAME_STATES.PLAY
		$AnimationPlayer.play("Dying")

func terminator():
	$Label.text = "I'll be back Bwahahaha!!"
	$Label.visible = true

func byeeeeee():
	queue_free()

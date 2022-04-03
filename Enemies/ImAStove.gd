extends SleepEnemies

onready var tween = $Tween
var can_attack :bool = true

func _ready():
	count = 8

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = $Stove.global_position
	$Attacks.add_child(attack)

func _on_Hit_Box_body_entered(body):
	if (body is KinematicBody2D) and (Settings.curGameState != Settings.GAME_STATES.BATTLE) and (can_attack != false):
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		attack_position()

func animate_spawns():
	var spawns = $Attacks.get_children()
	for atk in spawns:
		tween.interpolate_property(atk, 'position', atk.global_position, targets[spot].global_position, .5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tween.start()
		spot = spot + 1

func terminator():
	$Label.text = "Phew, I'm tired.  Time for a nap!"
	$Label.visible = true

func byeeeeee():
	$Label.visible = false
	$AnimationPlayer.stop()
	can_attack = false
	$Timer.start()

func _on_Timer_timeout():
	$AnimationPlayer.play("Idle")
	can_attack = true

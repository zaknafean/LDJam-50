extends SleepEnemies

onready var tween = $Tween
var whodonit 

func _ready():
	count = 4
	randomize()
	$Label.visible = false
	count = count * Settings.difficulty

func terminator():
	$Label.text = "You beat me! I hope that Sleep Deamon eats you!"
	$Label.visible = true

func _on_Hit_Box_body_entered(body):
	if body is KinematicBody2D and Settings.curGameState != Settings.GAME_STATES.BATTLE:
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		whodonit = body
		attack_position()

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = targets[spot].position
	$Attacks.add_child(attack)
	spot = spot + 1

func animate_spawns():
	var spawns = $Attacks.get_children()
	for atk in spawns:
		tween.interpolate_property(atk, 'position', atk.position, whodonit.position, .5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tween.start()
		spot = spot + 1

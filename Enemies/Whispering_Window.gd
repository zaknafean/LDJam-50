extends SleepEnemies

onready var tween = $Tween
var whodonit 

func _ready():
	count = 3
	randomize()
	$Label.visible = false


func terminator():
	$Label.text = "You beat me! I hope that Sleep Deamon eats you!"
	$Label.visible = true

func _on_Hit_Box_body_entered(body):
	if body is KinematicBody2D and Settings.curGameState != Settings.GAME_STATES.BATTLE:
		body.path = []
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		whodonit = body
		attack_position()

func animate_spawns():
	var spawns = $Attacks.get_children()
	for atk in spawns:
		tween.interpolate_property(atk, 'position', atk.position, whodonit.position, .5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tween.start()
		spot = spot + 1

func can_free_player():
	if $Attacks.get_child_count() == 0:
		Settings.curGameState = Settings.GAME_STATES.PLAY
		$AnimationPlayer.play("Dying")
	else:
		$Timer.start()

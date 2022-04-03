extends SleepEnemies

onready var tween = $Tween
#onready var move_targets = $Movement.get_children()

var can_attack :bool = true
var rotation_speed = PI
var follow = Vector2.ZERO

func _ready():
	look_for_kills = false
	$Label.visible = false
	$AnimationPlayer.play("Moving")
	count = 8
	spot = 0
	randomize()
	tween.connect("tween_completed", self, '_on_tween_completed()')

func _on_Hit_Box_body_entered(body):
	if (body is KinematicBody2D) and (Settings.curGameState != Settings.GAME_STATES.BATTLE) and (can_attack != false):
		body.path = []
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		print(Settings.curGameState, 'lamp state')
		$Label.visible = true
		attack_position()

func can_free_player():
	var pool = $Attacks.get_children()
	if pool.size() == 0:
		Settings.curGameState = Settings.GAME_STATES.PLAY
		$AnimationPlayer.play("Dying")
	else:
		pass

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = targets[spot].position
	$Target_Locations.add_child(attack)
	spot = spot + 1

func can_you_dig_it():
	$AnimationPlayer.stop()
	insert_dead_baby_joke()
	$AnimationPlayer.play("Moving")

func terminator():
	$Label.text = "Shucks...lights out for me!"
	$Label.visible = true

func byeeeeee():
	$Label.visible = false
	$AnimationPlayer.stop()
	can_attack = false
	
	var newguy = Sprite.new()
	newguy.position = $lampity/Sprite.global_position
	newguy.texture = load("res://assets/LampHop3.png")
	newguy.hframes = 6
	newguy.frame = 0
	newguy.scale = $lampity/Sprite.scale
	get_parent().add_child(newguy)
	
	Settings.score += 35 * Settings.difficulty
	
	queue_free()


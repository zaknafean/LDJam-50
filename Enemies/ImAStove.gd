extends SleepEnemies

onready var tween = $Tween
var can_attack :bool = true

func _ready():
	look_for_kills = false
	count = 8

func attack_position():
	targets = []
	for i in count:
		var pick
		pick = randi() % count + 1
		var cur_target = get_node('Target_Locations/Position2D'+str(pick))
		targets.append(cur_target)
	$Label.text = "I'm an ANGRY stove...Or you're hallucinating!"
	$Tutorial.visible = true
	$Stove/Atk_Sprite/AtkSpritePlayer.play("Attack")
	$AnimationPlayer.play("Attacking")
	

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = $Stove.global_position
	$Attacks.add_child(attack)
	attack.connect('attack_arrived', self, '_on_attack_arrived')
	attack.connect('attack_destroyed', self, '_on_attack_destroyed')

func _on_Hit_Box_body_entered(body):
	if (body is KinematicBody2D) and (Settings.curGameState != Settings.GAME_STATES.BATTLE) and (can_attack != false):
		$AmbientNoise.stop()
		body.path = []
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		$Stove/Atk_Sprite/AtkAudio.play()
		yield(get_tree(), "idle_frame")
		attack_position()

func animate_spawns():
	var spawns = $Attacks.get_children()
	for atk in spawns:
		tween.interpolate_property(atk, 'position', atk.global_position, targets[spot].global_position, .5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tween.start()
		spot = spot + 1

func terminator():
	$Label.text = "Phew, I'm tired.  Time for a nap. You better RUN!"
	$Label.visible = true

func byeeeeee():
	$Label.visible = false
	$AnimationPlayer.stop()
	can_attack = false
	
	var newguy = Sprite.new()
	newguy.position = self.global_position
	newguy.texture = load("res://assets/Stove.png")
	newguy.scale = $Stove/Sprite.scale
	get_parent().add_child(newguy)
	
	var score_value = 25 * Settings.difficulty
	Settings.adjust_score(str(score_value))
	if Settings.sanityValue > 5:
		Settings.adjust_sanity(str(-5))
	
	$Tutorial.queue_free()
	queue_free()
	

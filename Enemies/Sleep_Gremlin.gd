extends KinematicBody2D

export var count = 5
export var can_attack :bool 

var sleep_attack :NodePath = "res://Enemies/Sleep_Attack.tscn"
var attack_count = 0
var attack_instance
var targets = []

func _ready():
	randomize()
	$Label.visible = false
	can_attack = true

func _on_Hit_Box_body_entered(body):
	if body is KinematicBody2D and can_attack == true:
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
		print(targets)
	$AnimationPlayer.play("Attacking")


func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	for target in targets:
		var attack = attack_instance.instance()
		attack.position = target.global_position
		$Attacks.add_child(attack)
		yield(get_tree().create_timer(0.5), "timeout")








extends State
class_name BossFollow

@export var enemy : CharacterBody2D
@export var move_speed := 60.0

var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(delta: float):
	if owner.dying == true:
		Transitioned.emit(self, "Dying")
	var direction = Vector2(player.global_position.x - enemy.global_position.x, 0)
	print(direction.length())
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	
	if direction.length() > 300:
		Transitioned.emit(self, "BossIdle")

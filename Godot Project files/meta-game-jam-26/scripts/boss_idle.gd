extends State
class_name BossIdle

@export var enemy : CharacterBody2D
@export var move_speed := 10.0

var player: CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), 0)
	wander_time = randf_range(1, 3)

func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()


func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func physics_update(delta: float):
	if enemy:
		enemy.velocity.x = move_direction.x * move_speed

	var direction = Vector2(player.global_position.x - enemy.global_position.x, 0)
	
	if direction.length() < 300:
		Transitioned.emit(self, "BossFollow")

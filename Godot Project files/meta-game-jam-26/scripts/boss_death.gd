extends State
class_name BossDeath

@export var enemy : CharacterBody2D
@export var move_speed := 60.0

var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(delta: float):
	var direction = Vector2(0, 0)
	print(direction.length())
	enemy.velocity = Vector2()

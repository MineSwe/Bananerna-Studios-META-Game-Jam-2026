extends State
class_name BossAttack

@export var enemy : CharacterBody2D
@export var move_speed := 10.0

var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func update(delta: float):
	pass

func physics_update(delta: float):
	var direction = Vector2(player.global_position.x - enemy.global_position.x, 0)
	
	if direction.length() < 150:
		%AnimatedSprite2D.play("attack1")
		%CollisionPolygon2D.disabled = false
	
	if direction.length() > 150:
		Transitioned.emit(self, "BossFollow")
		%CollisionPolygon2D.disabled = true

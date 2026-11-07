extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var player_pos = get_parent().get_node("Player").position

const SPEED = 150.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	player_pos = get_parent().get_node("Player").position
	animation_handler()
		
		
func animation_handler() -> void:
	animated_sprite_2d.play("idle")
	if self.position.x > player_pos.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

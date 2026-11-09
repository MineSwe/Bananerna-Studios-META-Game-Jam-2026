extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var options = get_parent().get_node("IngameOptions/CanvasLayer")
@onready var attack_collision = $Area2D/AttackCollision
@onready var attack_collision_2: CollisionShape2D = $Area2D/AttackCollision2

var hp = 30
var dying = false

const SPEED = 160.0
var jump_velocity = -500.0

var is_talking = false
var is_attacking = false

func _ready():
	options.visible = false
	attack_collision.disabled = false

func _physics_process(delta: float) -> void:
	if dying == true:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and is_talking == false:
		velocity.y = jump_velocity


	if Input.is_action_just_pressed("esc"):
		if options.visible == false:
			options.visible = true
		else:
			options.visible = false
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if (options.visible == true or is_talking == true or is_attacking == true):
		direction = 0
		jump_velocity = 0
	else:
		jump_velocity = -400.0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	animation_handler()
	move_and_slide()
		
		
func take_damage(amount: int):
	hp -= amount
	await get_tree().create_timer(1.0).timeout
	if hp <= 0:
		dying = true
		await get_tree().create_timer(5.0).timeout
		get_tree().quit()
		
func animation_handler() -> void:
	if Input.is_action_just_pressed("attack") and is_attacking == false:
		is_attacking = true
		animated_sprite_2d.play("attack")
		if animated_sprite_2d.flip_h == false:
			attack_collision.disabled = false
			animated_sprite_2d.offset = Vector2(18, 0)
		else:
			attack_collision_2.disabled = false
			animated_sprite_2d.offset = Vector2(-18, 0)
	if is_attacking == true:
		pass
	elif velocity.x > 0:
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.play("idle")
	

func _on_grasshopper_dialog() -> void:
	is_talking = true

func _on_dialogue_ui_stopped_talking() -> void:
	is_talking = false

func _on_animated_sprite_2d_animation_looped() -> void:
	if is_attacking:
		is_attacking = false
		attack_collision_2.disabled = true
		attack_collision.disabled = true
		animated_sprite_2d.offset = Vector2(0, 0)
		animated_sprite_2d.play("idle")

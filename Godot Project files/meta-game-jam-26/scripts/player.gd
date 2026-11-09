extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var options = get_parent().get_node("IngameOptions/CanvasLayer")

const SPEED = 80.0
var jump_velocity = -400.0

var is_talking = false

func _ready():
	options.visible = false

func _physics_process(delta: float) -> void:
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
	if (options.visible == true or is_talking == true):
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
		
		
func animation_handler() -> void:
	if velocity.x > 0:
		animated_sprite_2d.play("ladybug")
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.play("ladybug")
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.play("idle")

func _on_grasshopper_dialog() -> void:
	is_talking = true

func _on_dialogue_ui_stopped_talking() -> void:
	is_talking = false

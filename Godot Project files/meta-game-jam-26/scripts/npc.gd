extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var getPlayer = get_parent().get_node("Player")
@onready var player_pos = getPlayer.position

var isInRange = false
var isTalking = false
signal dialog

func _physics_process(delta: float) -> void:
	player_pos = get_parent().get_node("Player").position
	animation_handler()
	if Input.is_action_pressed("ui_accept") && isInRange == true && isTalking == false:
		_dialog()
		
func animation_handler() -> void:
	animated_sprite_2d.play("idle")
	if self.position.x < player_pos.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

func _on_body_entered(body: Node2D) -> void:
	$Sprite2D.visible = true
	isInRange = true
	
	
func _on_body_exited(body: Node2D) -> void:
	$Sprite2D.visible = false
	isInRange = false

func _dialog():
	isTalking == true
	$Sprite2D.visible = false
	$Label.visible = true
	dialog.emit()

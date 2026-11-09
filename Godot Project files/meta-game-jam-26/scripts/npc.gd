extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var getPlayer = get_parent().get_node("Player")
@onready var player_pos = getPlayer.position

var is_in_range = false
var is_talking = false
signal dialog

func _physics_process(delta: float) -> void:
	player_pos = getPlayer.position
	animation_handler()
	if Input.is_action_pressed("talk") && is_in_range == true && is_talking == false:
		_dialog()
		
func animation_handler() -> void:
	if is_talking == false:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("talking")
	if self.position.x < player_pos.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
	

func _on_body_entered(body: Node2D) -> void:
	if is_talking == false:
		$TalkButton.visible = true
	is_in_range = true
	
	
func _on_body_exited(body: Node2D) -> void:
	$TalkButton.visible = false
	is_in_range = false

func _dialog():
	$TalkButton.visible = false
	is_talking = true
	dialog.emit()

func _on_dialogue_ui_stopped_talking() -> void:
	is_talking = false
	$TalkButton.visible = true

extends CharacterBody2D

var hp := 100
var dying = false

func take_damage(amount: int):
	$AnimatedSprite2D.play("hurt")
	hp -= amount
	await get_tree().create_timer(1.0).timeout
	
	$AnimatedSprite2D.play("walk")
	death()
	
func death():
	if hp <= 0:
		dying = true
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(2.0).timeout
		queue_free()
		AudioController.bgm_play()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		

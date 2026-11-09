extends CharacterBody2D

var hp := 100

func take_damage(amount: int):
	$AnimatedSprite2D.play("hurt")
	hp -= amount
	
func death():
	if hp <= 0:
		$AnimatedSprite2D.play("death")
		queue_free()
		AudioController.bgm_play()

func _physics_process(delta: float) -> void:
	death()
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		

extends Area2D
class_name HurtBox

func _init() -> void:
	collision_layer = 0
	collision_mask = 1
	
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
		
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		await get_tree().create_timer(1.0).timeout

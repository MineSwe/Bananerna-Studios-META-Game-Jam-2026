extends ProgressBar

@onready var boss: CharacterBody2D = $".."

func _process(delta: float) -> void:
	value = boss.hp

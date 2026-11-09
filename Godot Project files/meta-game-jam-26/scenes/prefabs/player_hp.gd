extends ProgressBar

@onready var player: CharacterBody2D = $".."

func _process(delta: float) -> void:
	value = player.hp

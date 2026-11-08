extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.main_menu_stop()
	AudioController.Intro_stop()
	AudioController.bgm_play()

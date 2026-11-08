extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !AudioController.main_menu_is_playing:
		AudioController.main_menu()

extends Node2D

@onready var audio_controller = AudioController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.main_menu_stop()
	AudioController.bgm_stop()
	AudioController.Intro_play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

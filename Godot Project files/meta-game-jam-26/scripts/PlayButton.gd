extends Button

@onready var fade_screen = get_node("../../../ColorRect")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_screen, "position", Vector2(0, 0), 1)
	tween.connect("finished", _on_tween_finished)
	

func _on_tween_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

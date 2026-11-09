extends Node
var is_talking = false
signal stopped_talking
var talk_speed = 20
var text = ["I'm talking"]
var current_text_id = 0
@onready var dialogue = $CanvasLayer/bg/dialogue

func _ready() -> void:
	dialogue.visible_ratio = 0

func _on_grasshopper_dialog() -> void:
	current_text_id = 0
	text = ["oh... hello...", "Didn't see you here", "Just 10 years ago it was all perfect", "Then the 1̷̼̪̩͔̀ͮ1̜̹̈ͧ̕͜0͍̞̮̥̑ͣ́͞0̪͎̎̐̍̑͜͝0͔̄͛̒ͭ͟͡0̧̢̥̠̊͒͠1̹̍͒͘͢͡0̷̮͈ͮ̀ͧ1̴̨̹͋̐0͓̹̯̀ͪ͒͂͝0̸̻̠̝̄̏̿ came..."]
	dialogue.text = text[current_text_id]
	is_talking = true
	$CanvasLayer.visible = true

func _physics_process(delta: float) -> void:
	if is_talking == true:
		if dialogue.visible_ratio != 1.0:
			dialogue.visible_ratio = minf(dialogue.visible_ratio + (talk_speed * delta / dialogue.text.length()), 1.0)
			if Input.is_action_just_pressed("ui_close_dialog"):
				dialogue.visible_ratio = 1.0
		else:
			if Input.is_action_just_pressed("ui_close_dialog"):
				current_text_id += 1
				dialogue.visible_ratio = 0
				if current_text_id >= text.size():
					is_talking = false
					$CanvasLayer.visible = false
					stopped_talking.emit()
				else:
					dialogue.text = text[current_text_id]

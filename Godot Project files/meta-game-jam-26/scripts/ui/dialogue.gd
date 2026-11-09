extends Node
var is_talking = false
signal stopped_talking
var talk_speed = 20
var text = ["I'm talking"]
var current_text_id = 0
@onready var dialogue = $CanvasLayer/bg/dialogue
@onready var options = get_parent().get_node("IngameOptions/CanvasLayer")

func _ready() -> void:
	dialogue.visible_ratio = 0

func _on_grasshopper_dialog() -> void:
	current_text_id = 0
	text = ["A newcomer!", 
		"You must go no further, s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m lives here...", 
		"s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m consumed...", 
		"s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m corrupted...",
		"my brethren...",
		"they are all s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m now...",
		"please...",
		"save them before̪̓ i̤t'́s̪ͭ t̲͍̓o͉̙̿o̘̓ͮ l̥ͯa̮̐t͚̰́̎e̲̞̙ͭͣ͊...",
	]
	dialogue.text = text[current_text_id]
	is_talking = true
	$CanvasLayer.visible = true

func _on_boss_dialog() -> void:
	current_text_id = 0
	text = [
		"0̲͍̓1͉̙̿1̘̓ͮ0͙̒0̥ͯ0̮̐1͚̰́̎0̲̞̙ͭͣ͊0͓ͅ1̗̉0̟͗ͥ̇0ͧ",
		"0̼ͫ̔0͔̤1͋̊1̓ 0ͦ1̳̋͂0̣1͓̌̾0͉̩͒01͕͈͋ͦ",
		"Ah, a newcomer...",
		"Come closer... s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m is here...",
		"join s̷̛̗̯͆̃̀w̸̳̹̋̇͒͝a̷͇͌r̴͍͖̯̎̋͝m... or  d i e",
	]
	dialogue.text = text[current_text_id]
	is_talking = true
	$CanvasLayer.visible = true

func _physics_process(delta: float) -> void:
	if is_talking == true and options.visible == false:
		if dialogue.visible_ratio != 1.0:
			dialogue.visible_ratio = minf(dialogue.visible_ratio + (talk_speed * delta / dialogue.text.length()), 1.0)
			if Input.is_action_just_pressed("stop_talk"):
				dialogue.visible_ratio = 1.0
		else:
			if Input.is_action_just_pressed("stop_talk"):
				current_text_id += 1
				dialogue.visible_ratio = 0
				if current_text_id >= text.size():
					is_talking = false
					$CanvasLayer.visible = false
					stopped_talking.emit()
				else:
					dialogue.text = text[current_text_id]

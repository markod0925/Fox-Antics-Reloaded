extends AcceptDialog


@onready var label_high_score = $"../LabelHighScore"
@onready var dialog_bg = $"../DialogBG"

const HS_FILE: String = "user://SCORES.dat"

func _ready():
	add_cancel_button("Cancel")

func reset_highscore() -> void:
	label_high_score.text = "HIGHSCORE: 0"
	var file = FileAccess.open(HS_FILE, FileAccess.WRITE)
	var data = {
		"highscore": 0
	}
	file.store_string(JSON.stringify(data))
	dialog_bg.hide()


func _on_canceled():
	dialog_bg.hide()


func _on_confirmed():
	reset_highscore()

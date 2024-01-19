extends Button


@onready var label_high_score = $"../VB/LabelHighScore"

const HS_FILE: String = "user://SCORES.dat"

func _on_pressed():
	label_high_score.text = "HIGHSCORE: 0"
	var file = FileAccess.open(HS_FILE, FileAccess.WRITE)
	var data = {
		"highscore": 0
	}
	
	file.store_string(JSON.stringify(data))

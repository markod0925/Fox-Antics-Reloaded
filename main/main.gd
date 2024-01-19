extends CanvasLayer


@onready var label_high_score = $LabelHighScore
@onready var menu_audio = $MenuAudio


func _ready():
	get_tree().paused = false
	label_high_score.text = "HIGHSCORE: " + str(ScoreManager.get_highscore())
	SoundManager.play_clip(menu_audio, SoundManager.SOUND_MAIN_MENU)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#if Input.is_action_just_pressed("jump") == true:
		#GameManager.load_next_level_scene()

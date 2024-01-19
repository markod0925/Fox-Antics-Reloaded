extends Control


@onready var level_complete_level_name = $ColorRect/VB_LevelComplete/LevelCompleteLevelName
@onready var label_level_complete = $ColorRect/VB_LevelComplete/LabelLevelComplete
@onready var color_rect = $ColorRect
@onready var vb_level_complete = $ColorRect/VB_LevelComplete
@onready var vb_game_over = $ColorRect/VB_GameOver
#@onready var hb_hearts = $MC/HB/HB_Hearts
@onready var heart_lives_label = $LifeCountContainer/HB/HeartLivesLabel
@onready var score_label = $ScoreLabelContainer/ScoreLabel
@onready var vb_game_complete = $ColorRect/VB_GameComplete
@onready var final_score = $ColorRect/VB_GameComplete/HBoxContainer/FinalScore
@onready var high_score = $ColorRect/VB_GameComplete/HBoxContainer/HighScore
#@onready var gem_score_label = $GemScoreContainer/HB/GemScoreLabel
#@onready var coin_score_label = $CoinScoreContainer/HB/CoinScoreLabel
@onready var level_label = $LevelNameContainer/VBoxContainer/LevelLabel
@onready var level_name_label = $LevelNameContainer/VBoxContainer/LevelNameLabel
@onready var level_name_container = $LevelNameContainer
@onready var level_name_timer = $LevelNameTimer
@onready var game_pause_menu = $GamePauseMenu
@onready var fire_works = $Fireworks/FireWorks
@onready var fire_works_4 = $Fireworks/FireWorks4
@onready var fire_works_3 = $Fireworks/FireWorks3
@onready var fire_works_2 = $Fireworks/FireWorks2
@onready var fireworks = $Fireworks
@onready var sound = $Sound
@onready var level_win = $LevelWin
@onready var stars_found_label = $StarScoreContainer/HB/StarsFoundLabel
@onready var stars_in_level_label = $StarScoreContainer/HB/StarsInLevelLabel
@onready var gems_found_label = $GemScoreContainer/HB/GemsFoundLabel
@onready var gems_in_level_label = $GemScoreContainer/HB/GemsInLevelLabel
@onready var coins_found_label = $CoinScoreContainer/HB/CoinsFoundLabel
@onready var coins_in_level_label = $CoinScoreContainer/HB/CoinsInLevelLabel
@onready var heart_container_2 = $HeartContainer2
@onready var life_count_container_2 = $LifeCountContainer2
@onready var heart_lives_label_2 = $LifeCountContainer2/HB/HeartLivesLabel


var _level_names: Array = ["MISTY MOUNTAINS", "FORGOTTEN SANDS", "ENACHANTED FORREST", "CRYSTAL FALLS"]
#var _hearts: Array
var _stars_found: int = 0
var _coins_found: int = 0
var _gems_found: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	level_name_timer.start()
	level_label.text = "LEVEL %s" % str(GameManager.current_level)
	level_name_label.text = _level_names[GameManager.current_level -1]
	
	stars_found_label.text = str(_stars_found)
	#gems_found_label.text = str(ScoreManager.get_gems_score())
	#coins_found_label.text = str(ScoreManager.get_coins_score())
	score_label.text = "SCORE: " + str(ScoreManager.get_score())
	update_lives_txt()
	
	#_hearts = hb_hearts.get_children()
	SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_gem_picked_up.connect(on_gem_picked_up)
	SignalManager.on_coin_picked_up.connect(on_coin_picked_up)
	SignalManager.on_life_star_picked_up.connect(on_life_star_picked_up)
	SignalManager.get_life_stars.connect(get_life_stars)
	SignalManager.get_coins.connect(get_coins)
	SignalManager.get_gems.connect(get_gems)
	if GameManager.get_player_2():
		heart_container_2.show()
		life_count_container_2.show()
	else:
		heart_container_2.hide()
		life_count_container_2.hide()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel") == true:
		get_tree().paused = true
		color_rect.show()
		game_pause_menu.show()
		
	if vb_level_complete.visible == true:
		if Input.is_action_just_pressed("jump1"):
			GameManager.load_next_level_scene()
			
	if vb_game_over.visible == true:
		if Input.is_action_just_pressed("jump1") == true:
			GameManager.load_main_scene()
			
	if vb_game_complete.visible == true:
		if Input.is_action_just_pressed("jump1") == true:
			GameManager.load_main_scene()


func get_life_stars(stars: int) -> void:
	stars_in_level_label.text = str(stars)


func get_coins(coins: int) -> void:
	coins_in_level_label.text = str(coins)


func get_gems(gems: int) -> void:
	gems_in_level_label.text = str(gems)


func on_life_star_picked_up() -> void:
	_stars_found += 1
	PlayerVariables.inc_lives()
	update_lives_txt()
	stars_found_label.text = str(_stars_found)


func update_lives_txt() -> void:
	heart_lives_label.text = str(PlayerVariables.get_lives(1))
	if GameManager.get_player_2():
		heart_lives_label_2.text = str(PlayerVariables.get_lives(2))


func on_coin_picked_up() -> void:
	_coins_found += 1
	coins_found_label.text = str(_coins_found)
	#coin_score_label.text = str(ScoreManager.get_coins_score())
	
	
func on_gem_picked_up() -> void:
	_gems_found += 1
	gems_found_label.text = str(_gems_found)
	#gem_score_label.text = str(ScoreManager.get_gems_score())
	

func on_score_updated() -> void:
	score_label.text = "SCORE: " + str(ScoreManager.get_score())


func random_vector() -> Vector2:
	var min_x: float = 100.0
	var max_x: float = 900
	var min_y: float = 30
	var max_y: float = 300
	return Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))


func random_animation_position(animated_sprite: AnimatedSprite2D) -> void:
	animated_sprite.position.x = random_vector().x
	animated_sprite.position.y = random_vector().y


func show_hud() -> void:
	get_tree().paused = true
	color_rect.visible = true


func on_player_hit() -> void:
	update_lives_txt()


func on_level_complete() -> void:
	if GameManager.current_level == GameManager.TOTAL_LEVELS:
		vb_game_complete.visible = true
		fireworks.show()
		final_score.text = "final score: " + str(ScoreManager.get_score())
		high_score.text = "high score: " + str(ScoreManager.get_highscore())
		show_hud()
		return
		
	vb_level_complete.visible = true
	level_complete_level_name.text = _level_names[GameManager.current_level -1]
	level_win.play()
	show_hud()


func on_game_over() -> void:
	vb_game_over.visible = true
	SoundManager.play_clip(sound, SoundManager.SOUND_GAMEOVER)
	show_hud()


func _on_level_name_timer_timeout():
	level_name_container.hide()


func _on_fire_works_animation_looped():
	random_animation_position(fire_works)
	fire_works.play()


func _on_fire_works_4_animation_looped():
	random_animation_position(fire_works_4)
	fire_works_4.play()


func _on_fire_works_3_animation_looped():
	random_animation_position(fire_works_3)
	fire_works_3.play()


func _on_fire_works_2_animation_looped():
	random_animation_position(fire_works_2)
	fire_works_2.play()

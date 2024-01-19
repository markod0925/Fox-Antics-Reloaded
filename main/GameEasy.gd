extends Button


func _on_pressed():
	GameManager.load_next_level_scene()
	PlayerVariables.player_lives = 15

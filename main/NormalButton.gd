extends TextureButton


func _on_pressed():
	GameManager.load_next_level_scene()
	GameManager.set_difficulty(GameManager.DIFFICULTY_KEYS.NORMAL)
	PlayerVariables.set_start_values(GameManager.get_initial_lifes())


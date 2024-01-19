extends ConfirmationDialog


func _on_confirmed():
	GameManager.load_main_scene()

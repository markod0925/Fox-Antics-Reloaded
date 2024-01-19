extends TextureButton
@onready var color_rect = $"../../../ColorRect"
@onready var game_pause_menu = $"../.."


func _on_pressed():
	get_tree().paused = false
	color_rect.hide()
	game_pause_menu.hide()
	



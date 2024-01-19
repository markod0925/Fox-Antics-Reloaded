extends TextureButton
@onready var quit_game_confirm = $"../../QuitGameConfirm"


func _on_pressed():
	quit_game_confirm.popup_centered()
	quit_game_confirm.show()

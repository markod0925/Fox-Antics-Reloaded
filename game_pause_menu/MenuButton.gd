extends TextureButton


@onready var quit_to_menu = $"../../QuitToMenu"



func _on_pressed():
	quit_to_menu.popup_centered()
	quit_to_menu.show()

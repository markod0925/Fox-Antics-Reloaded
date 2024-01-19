extends Button


@onready var accept_dialog = $"../AcceptDialog"
@onready var dialog_bg = $"../DialogBG"


func _on_pressed():
	accept_dialog.set_text("This will delete your highscore. Are you sure?")
	accept_dialog.popup_centered()
	dialog_bg.show()

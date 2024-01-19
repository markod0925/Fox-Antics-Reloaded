extends CheckBox


func _ready():
	set_pressed(GameManager.get_player_2())


func _on_toggled(toggled_on):
	GameManager.set_player_2(toggled_on)

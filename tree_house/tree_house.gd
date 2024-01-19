extends Sprite2D


@onready var earth_rumble_sound = $EarthRumbleSound
@onready var game_complete_sound = $GameCompleteSound
@onready var house_animation = $HouseAnimation
@onready var door_animation = $DoorAnimation
@onready var door = $door


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_boss_explosion_finished.connect(on_boss_explosion_finished)


func on_boss_explosion_finished() -> void:
	door.hide()
	house_animation.play("house_reveal")
	earth_rumble_sound.play()


func _on_earth_rumble_sound_finished():
	game_complete_sound.play()
	SignalManager.on_earh_rumble_sound_finished.emit()


func _on_game_complete_sound_finished():
	door.show()
	SignalManager.player_physics.emit()
	SignalManager.on_game_complete_sound_finished.emit()
	door_animation.play("door")
	

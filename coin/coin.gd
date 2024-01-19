extends Area2D

@export var points: int = 1

@onready var sound_player = $SoundPlayer


func _on_area_entered(_area):
	SoundManager.play_clip(sound_player, SoundManager.SOUND_COIN)
	SignalManager.on_pickup_hit.emit(points)
	SignalManager.on_coin_picked_up.emit()
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEY.ITEM_PICKUP)
	hide()
	global_position.y += -1000


func _on_sound_player_finished():
	set_process(false)
	queue_free()

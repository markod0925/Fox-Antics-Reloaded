extends Area2D

@onready var sound = $Sound
@export var points: int = 15


func _on_sound_finished():
	set_process(false)
	queue_free()


func _on_area_entered(_area):
	SoundManager.play_clip(sound, SoundManager.SOUND_LIFE_STAR)
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEY.LIFE_PICKUP)
	#PlayerVariables.player_lives += 1
	SignalManager.on_life_star_picked_up.emit()
	SignalManager.on_pickup_hit.emit(points)
	hide()
	global_position.y += -1000

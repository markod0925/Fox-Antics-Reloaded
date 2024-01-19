extends Area2D


@export var points: int = 5

@onready var gem_pickup = $GemPickup


func _on_area_entered(_area):
	SoundManager.play_clip(gem_pickup, SoundManager.SOUND_GEM)
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEY.ITEM_PICKUP)
	SignalManager.on_pickup_hit.emit(points)
	SignalManager.on_gem_picked_up.emit()
	hide()
	global_position.y += -1000


func _on_gem_pickup_finished():
	set_process(false)
	queue_free()




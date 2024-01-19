extends Node2D

@onready var house_reveal_timer = $HouseRevealTimer
@onready var dust_effect_4 = $DustEffect4


# Called when the node enters the scene tree for the first time.
func _ready():
	house_reveal_timer.start()
	SignalManager.on_boss_explosion_finished.connect(on_boss_explosion_finished)
	SignalManager.on_earh_rumble_sound_finished.connect(on_earh_rumble_sound_finished)


func get_dust_effects() -> Array:
	return get_tree().get_nodes_in_group("dust effects")
	

func on_boss_explosion_finished() -> void:
	for effect in get_dust_effects():
		effect.play()
		effect.show()


func on_earh_rumble_sound_finished() -> void:
	for effect in get_dust_effects():
		effect.stop()
		effect.hide()


func _on_house_reveal_timer_timeout():
	pass

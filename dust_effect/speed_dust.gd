extends AnimatedSprite2D

@onready var speed_boost = $SpeedBoost


func _ready():
	SoundManager.play_clip(speed_boost, SoundManager.SOUND_SPEED_BOOST)


func _on_speed_boost_finished():
	queue_free()

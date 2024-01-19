extends AnimatedSprite2D

@onready var waterfall_sound = $WaterfallSound


func _ready():
	SoundManager.play_clip(waterfall_sound, SoundManager.SOUND_WATERFALL)

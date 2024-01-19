extends PathFollow2D


@export var speed: float = 0.04
@onready var saw_sound = $SawSound

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_clip(saw_sound, SoundManager.SOUND_CIRCULAR_SAW)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio = progress_ratio + delta * speed

extends PathFollow2D


@export var speed: float = 0.04
@onready var ball_spikes_spin = $BallSpikesSpin


func _ready():
	SoundManager.play_clip(ball_spikes_spin, SoundManager.SOUND_BALL_SPIKES_SPIN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio = progress_ratio + delta * speed

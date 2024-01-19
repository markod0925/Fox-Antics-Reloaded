extends EnemyBase


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var turn_detector = $TurnDetector
@onready var blue_bird_sound = $BlueBirdSound


func _ready():
	super._ready()
	var random_speed = randf_range(40, 90)
	
	speed = random_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	velocity.x = _facing * speed
	move_and_slide()
	
	if turn_detector.is_colliding() == true:
		flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	turn_detector.position.x = turn_detector.position.x * -1 
	
	if _facing == FACING.LEFT:
		_facing = FACING.RIGHT
		turn_detector.rotation_degrees = -90.0
		SoundManager.play_clip(blue_bird_sound, SoundManager.SOUND_BLUE_BIRD)
	else:
		_facing = FACING.LEFT
		turn_detector.rotation_degrees = 90.0
		SoundManager.play_clip(blue_bird_sound, SoundManager.SOUND_BLUE_BIRD)

extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var floor_detection = $FloorDetection
@onready var player_detector = $PlayerDetector
@onready var shooter = $Shooter



func _ready():
	super._ready()
	var random_speed = randf_range(30, 80)
	speed = random_speed


func _physics_process(delta):
	super._physics_process(delta)
	
	if is_on_floor() == false:
		velocity.y += _gravity * delta
	else:
		velocity.x = _facing * speed
		
	move_and_slide()
	
	shoot()
	
	if is_on_wall() == true or floor_detection.is_colliding() == false:
		flip_me()

func shoot() -> void:
	if player_detector.is_colliding() == true:
		shooter.shoot(global_position.direction_to(_player_ref.global_position))


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1 
	
	if _facing == FACING.LEFT:
		_facing = FACING.RIGHT
		player_detector.rotation_degrees = -90.0
	else:
		_facing = FACING.LEFT
		player_detector.rotation_degrees = 90.0

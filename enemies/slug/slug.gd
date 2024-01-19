extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var floor_detection = $FloorDetection
@onready var player_detector = $PlayerDetector
@onready var shooter = $Shooter

@onready var go_faster = $GoFaster
@onready var go_normal = $GoNormal

var _can_shoot: bool = true


func _physics_process(delta):
	super._physics_process(delta)
	
	if is_on_floor() == false:
		velocity.y += _gravity * delta
	else:
		velocity.x = _facing * _speed
		
	move_and_slide()
	
	shoot()
	
	if is_on_wall() == true or floor_detection.is_colliding() == false:
		flip_me()

func shoot() -> void:
	if player_detector.is_colliding() == true and _can_shoot == true:
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


func _on_go_normal_timeout():
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEY.SPEED_DUST)
	_speed = 80
	_can_shoot = false
	animated_sprite_2d.speed_scale = 2
	go_normal.stop()
	go_faster.start()


func _on_go_faster_timeout():
	_speed = 20
	_can_shoot = true
	animated_sprite_2d.speed_scale = 1
	go_faster.stop()
	go_normal.start()

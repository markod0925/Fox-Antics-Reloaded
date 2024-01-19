extends EnemyBase


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var floor_detection = $FloorDetection


func _ready():
	super._ready()
	var random_speed = randf_range(70, 100)
	speed = random_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	
	if is_on_floor() == false:
		velocity.y += _gravity * delta
	else:
		velocity.x = _facing * speed
		
	move_and_slide()
	
	if is_on_wall() == true or floor_detection.is_colliding() == false:
		flip_me()
		
		
func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1 
	
	if _facing == FACING.LEFT:
		_facing = FACING.RIGHT
	else:
		_facing = FACING.LEFT

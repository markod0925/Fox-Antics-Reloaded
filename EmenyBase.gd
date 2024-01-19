extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var floor_detection = $FloorDetection
@onready var player_detector = $PlayerDetector
@onready var angry_timer = $AngryTimer
@onready var anger_recovery = $AngerRecovery


var anger:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	
	if is_on_floor() == false:
		velocity.y += _gravity * delta
	else:
		velocity.x = _facing * speed
		
	move_and_slide()
	get_angry()
	if is_on_wall() == true or floor_detection.is_colliding() == false:
		flip_me()
		
		
func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1 
	
	if _facing == FACING.LEFT:
		_facing = FACING.RIGHT
		player_detector.rotation_degrees = -90.0
	else:
		_facing = FACING.LEFT
		player_detector.rotation_degrees = 90.0


func get_angry() -> void:
	if player_detector.is_colliding() == true and anger == true:
		ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEY.SPEED_DUST)
		speed = 150
		anger = false
		animated_sprite_2d.speed_scale = 2
		angry_timer.start()

func _on_angry_timer_timeout():
	angry_timer.stop()
	
	speed = 40	
	animated_sprite_2d.speed_scale = 1
	anger_recovery.start()


func _on_anger_recovery_timeout():
	anger = true

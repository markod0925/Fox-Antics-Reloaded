extends Area2D


var _direction: Vector2 = Vector2.RIGHT
var _life_span: float = 20.0
var _life_time: float = 0.0
var _smoothing_factor : float = 0.95 # Smoothing Factor
@onready var sprite = $Sprite2D
@onready var sprite_basic_scale : Vector2 = sprite.scale

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_expired(delta)
	position += _direction * delta
	sprite.scale = lerp(sprite_basic_scale * Vector2(1.4, 0.5), sprite_basic_scale, 1 - exp(-_smoothing_factor * _life_time))
	sprite.rotation = _direction.angle()


func setup(dir: Vector2, life_span: float, speed: float) -> void:
	_direction = dir.normalized() * speed
	_life_span = life_span


func check_expired(delta: float) -> void:
	_life_time += delta
	if _life_time > _life_span:
		queue_free()

func _on_area_entered(_area):
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

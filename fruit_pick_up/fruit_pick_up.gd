extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sound_pickup = $SoundPickup
@onready var heart_scene : PackedScene = preload("res://heart/heart.tscn")
@export var points: int = 2


const FRUITS: Array = [ "melon", "kiwi", "banana", "cherry"]
const GRAVITY: float = 150.0
const JUMP: float = -80.0


var _start_y: float
var _speed_y: float = JUMP
var _stopped: bool = false
var _is_heart: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_y = global_position.y
	_is_heart = randf() <= GameManager.get_perc_heart()
	if _is_heart:
		#var new_heart = heart_scene.instantiate()
		#scale = Vector2i(0.75, 0.75)
		##new_heart.global_position = global_position
		#animated_sprite_2d.hide()
		#add_child(new_heart)
		#new_heart.pivot_offset = Vector2.ZERO
		#pass
		animated_sprite_2d.play("heart")
	else:
		animated_sprite_2d.play(FRUITS.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _stopped == true:
		return

	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta
	
	if global_position.y >= _start_y:
		_stopped = true


func kill_me() -> void:
	set_process(false)
	queue_free()


func _on_life_timer_timeout():
	#kill_me()
	pass

func pickup_original_position() -> Vector2:
	return Vector2(global_position.x, global_position.y)


func _on_area_entered(_area):
	ObjectMaker.create_simple_scene(pickup_original_position(), ObjectMaker.SCENE_KEY.ITEM_PICKUP)
	if _is_heart:
		SignalManager.on_life_star_picked_up.emit()
		#SignalManager.on_heart_hit.emit()
	else:
		SignalManager.on_pickup_hit.emit(points)
	global_position.y += -1000
	SoundManager.play_clip(sound_pickup, SoundManager.SOUND_FRUIT_BITE)
	hide()


func _on_sound_pickup_finished():
	kill_me()

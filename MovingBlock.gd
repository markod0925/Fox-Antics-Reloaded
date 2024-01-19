extends AnimatableBody2D

@export var point_1: Marker2D
@export var point_2: Marker2D
@export var speed: float = 50.0
@onready var stone_scrape = $StoneScrape


var _time_to_move: float = 0.0
var _tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	set_time_to_move()
	set_moving()
	SoundManager.play_clip(stone_scrape, SoundManager.SOUND_STONE_SCRAPE)


func _exit_tree() -> void:
	_tween.kill()


func set_time_to_move() -> void:
	var delta = point_1.global_position.distance_to(point_2.global_position)
	_time_to_move = delta / speed


func set_moving() -> void:
	_tween = get_tree().create_tween()
	_tween.set_loops(0)
	_tween.tween_property(self, "global_position", point_1.global_position, _time_to_move)

	_tween.tween_property(self, "global_position", point_2.global_position, _time_to_move)


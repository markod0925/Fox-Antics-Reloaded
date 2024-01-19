extends Camera2D


@onready var shake_timer = $ShakeTimer
@onready var game_complete_timer = $GameCompleteTimer
@export var shake_amount: float = 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_game_complete.connect(on_game_complete)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	offset = get_random_offset()


func on_game_complete() ->void:
	set_process(true)
	game_complete_timer.start()


func on_game_over() -> void:
	reset_camera()


func shake() -> void:
	set_process(true)
	shake_timer.start()


func get_random_offset() -> Vector2:
	return Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)
	)


func reset_camera() -> void:
	set_process(false)
	offset = Vector2.ZERO

func _on_shake_timer_timeout():
	reset_camera()


func on_player_hit() -> void:
	shake()


func _on_game_complete_timer_timeout():
	reset_camera()

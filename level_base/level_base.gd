extends Node2D

@onready var player_cam = $PlayerCam
@onready var player : Player = $Player
@onready var level_name_container = $HUD/LevelNameContainer
@onready var timer = $Timer
@onready var audio_stream_player = $AudioStreamPlayer
@onready var coins = $Coins
@onready var player_2 : Player = $Player2

const MARGIN : float = 20.0

var _cam_position_change: bool = false
var _game_finished: bool = false
var _game_complete_cam_left_limit: float = 9430.0
var _game_boundry_position:Vector2 = Vector2(9420, 0)
var _lower_right : Vector2 = Vector2.ZERO
var _upper_left : Vector2 = Vector2.ZERO
var _vp : Rect2

func _ready():
	get_tree().paused = false
	SignalManager.get_life_stars.emit(get_number_of_stars())
	SignalManager.get_coins.emit(get_number_of_coins())
	SignalManager.get_gems.emit(get_number_of_gems())
	SignalManager.on_player_hit.emit()
	SignalManager.on_game_complete.connect(on_game_complete)
	SignalManager.on_game_complete_sound_finished.connect(on_game_complete_sound_finished)
	if GameManager.get_player_2():
		player_2.show()
		player_2.set_physics_process(true)
		player_2.set_process(true)
		player_cam.zoom = Vector2(1.25, 1.25)
	else:
		player_2.hide()
		player_2.set_physics_process(false)
		player_2.set_process(false)
		player_cam.zoom = Vector2(2, 2)		
	_vp = get_viewport_rect()


func get_number_of_coins() -> int:
	return get_tree().get_nodes_in_group("Coins").size()


func get_number_of_gems() -> int:
	return get_tree().get_nodes_in_group("Gems").size()


func get_number_of_stars() -> int:
	return get_tree().get_nodes_in_group("Star").size()

func on_game_complete() -> void:
	audio_stream_player.set_volume_db(-20.0)
	_cam_position_change  = true


func on_game_complete_sound_finished() -> void:
	audio_stream_player.set_volume_db(-10.0)
	_cam_position_change  = false


func _process(_delta):
	
	#var outtext = "UL: %s, LR: %s" %[_upper_left, _lower_right]
	#print(outtext)
	
	if _game_finished == true:
		ObjectMaker.create_simple_scene(_game_boundry_position, ObjectMaker.SCENE_KEY.BOUNDRY)
		player_cam.limit_left = 9430.0
		
	player_cam.position = player.position
	#print(player_cam.zoom)
	if player.is_visible() and player_2.is_visible():
		player_cam.position = (player.position + player_2.position)/2
		#var diff = (player.position - player_2.position) #1024 x 600
		#diff /= Vector2(1024.0/2, 600.0/2)
		#var x = max(abs(diff.x), abs(diff.y))
		#if x > 0.7:
			#var target_point = (-1.14*x+0.92) *  Vector2(1, 1)
			#var pcz : Vector2 = player_cam.zoom
			#pcz += target_point
			#pcz /= 2
			#player_cam.zoom = pcz.clamp(Vector2(1.25, 1.25), Vector2(2, 2))
		#else:
			#var pcz : Vector2 = player_cam.zoom
			#pcz.lerp(Vector2(2, 2), 0.5)
			#player_cam.zoom = pcz
	elif player.is_visible():
		player_cam.position = player.position
	elif player_2.is_visible():
		player_cam.position = player_2.position
			
	if _cam_position_change == true:
		player_cam.position = Vector2(10080, 32)
		_game_finished = true
	
	_lower_right = Vector2(
		player_cam.position.x + _vp.size.x/(2*player_cam.zoom.x) - MARGIN,
		player_cam.position.y + _vp.size.y/(2*player_cam.zoom.y) - MARGIN,
	)
	_upper_left = Vector2(
		player_cam.position.x - _vp.size.x/(2*player_cam.zoom.x) + MARGIN,
		player_cam.position.y - _vp.size.y/(2*player_cam.zoom.y) + MARGIN,
	)
	
	if not _game_finished:
		var players_list = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)
		for playr in players_list:
			if playr.is_visible():
				if playr.position.x > _lower_right.x: 
					playr.set_move_block(Player.PLAYER_MOVES_BLOCK.RIGHT)
					playr.velocity = Vector2.ZERO
				if playr.position.x < _upper_left.x: 
					playr.set_move_block(Player.PLAYER_MOVES_BLOCK.LEFT)
					playr.velocity = Vector2.ZERO
				if playr.position.y < _upper_left.y: 
					playr.set_move_block(Player.PLAYER_MOVES_BLOCK.UP)
					playr.velocity = Vector2.ZERO
				#player.position.y > _lower_right.y
				playr.position = playr.position.clamp(_upper_left, _lower_right)
				if playr.position.x < _lower_right.x-2 and playr.position.x > _upper_left.x+2 and playr.position.y < _lower_right.y-2 and playr.position.y > _upper_left.y+2 :
					playr.set_move_block(Player.PLAYER_MOVES_BLOCK.NONE)


func _on_timer_timeout():
	level_name_container.hide()

extends CharacterBody2D

class_name Player

@onready var fox = $fox
@onready var animation_player = $AnimationPlayer
@onready var debug_label = $DebugLabel
@onready var sound_player = $SoundPlayer
@onready var shooter = $Shooter
@onready var animation_player_invincible = $AnimationPlayerInvincible
@onready var invincible_timer = $InvincibleTimer
@onready var hurt_timer = $HurtTimer
@onready var hit_box = $HitBox
@onready var sound_fall = $SoundFall
@onready var audio_stream_player = $"../AudioStreamPlayer"

@export_range(1, 2) var player_number : int = 1


const GRAVITY: float = 900.0
const RUN_SPEED : float= 120.0
const MAX_FALL: float = 400.0
const FALLEN_OFF: float = 10.0
const JUMP_VELOCITY: float = -400.0
const DOUBLE_JUMP_VELOCITY: float = -250.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2( 0, -150.0)
const PLAYER_START_POSITION_X: float = -182.0
const PLAYER_START_POSITION_Y: float = -50.0

enum PLAYER_STATE { IDLE, RUN, JUMP, FALL, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE
var _invincible: bool = false
var _can_double_jump:bool = false
var _checkpoint_active = true

enum PLAYER_MOVES_BLOCK { NONE, UP, LEFT, RIGHT }
var _mov_block: PLAYER_MOVES_BLOCK = PLAYER_MOVES_BLOCK.NONE

var _inname_shoot : String
var _inname_left : String
var _inname_right : String
var _inname_jump : String

func _ready():
	SignalManager.on_player_hit.emit()
	SignalManager.on_game_complete.connect(on_game_complete)
	SignalManager.player_physics.connect(player_physics)
	_inname_shoot = "shoot" + str(player_number)
	_inname_left = "left" + str(player_number)
	_inname_right = "right" + str(player_number)
	_inname_jump = "jump" + str(player_number)


func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
	
	get_input()
	move_and_slide()	
	calculate_states()
	#update_debug_label()
	
	if Input.is_action_just_pressed(_inname_shoot) == true:
		shoot()
		
	#if Input.is_action_just_pressed("shoot_up") == true:
		#shoot_up()

func set_move_block(new_state: PLAYER_MOVES_BLOCK) -> void:
	_mov_block = new_state


func fallen_off() -> void:
	if global_position.y > FALLEN_OFF:
		set_physics_process(false)
		SoundManager.play_clip(sound_fall, SoundManager.SOUND_FALL)


func on_game_complete() -> void:
	if is_on_floor() == true:
		set_physics_process(false)
		animation_player.stop()


func player_physics() -> void:
	set_physics_process(true)


func _on_sound_fall_finished():
	if reduce_lives() == false:
		return
	hide()
	var players_list = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)
	var target_pos = Vector2(PLAYER_START_POSITION_X, PLAYER_START_POSITION_Y)
	for playr in players_list:
		if playr != self and playr.is_visible():
			target_pos = playr.global_position
	global_position = target_pos
	show()
	go_invincible()
	set_physics_process(true)


func shoot() -> void:
	if fox.flip_h == true:
		shooter.shoot(Vector2.LEFT)
	else:
		shooter.shoot(Vector2.RIGHT)

func shoot_up() -> void:
	shooter.shoot(Vector2.UP)


func update_debug_label() -> void:
	debug_label.text = "floor:%s\n%s\n%0f,%0f" % [
		is_on_floor(),
		PLAYER_STATE.keys()[_state],
		velocity.x, velocity.y
	]


func get_input() -> void:
	if _state == PLAYER_STATE.HURT:
		return
	
	velocity.x = 0

	if Input.is_action_pressed(_inname_left) and _mov_block != PLAYER_MOVES_BLOCK.LEFT:
		velocity.x = -RUN_SPEED
		fox.flip_h = true
		
	elif Input.is_action_pressed(_inname_right) and _mov_block != PLAYER_MOVES_BLOCK.RIGHT:
		velocity.x = RUN_SPEED
		fox.flip_h = false
		
	if Input.is_action_just_pressed(_inname_jump) and is_on_floor() and _mov_block != PLAYER_MOVES_BLOCK.UP:
		
		velocity.y = JUMP_VELOCITY
		ObjectMaker.create_simple_scene(get_jump_dust_position(), ObjectMaker.SCENE_KEY.JUMP_SMOKE)
		sound_player.pitch_scale = 1
		sound_player.volume_db = 0
		SoundManager.play_clip(sound_player, SoundManager.SOUND_JUMP)
		_can_double_jump = true
	
	
	if Input.is_action_just_pressed(_inname_jump) and not is_on_floor() and _can_double_jump and _mov_block != PLAYER_MOVES_BLOCK.UP:
		velocity.y = DOUBLE_JUMP_VELOCITY
		ObjectMaker.create_simple_scene(get_jump_dust_position(), ObjectMaker.SCENE_KEY.DOUBLE_JUMP_SMOKE)
		sound_player.pitch_scale = 1.1
		sound_player.volume_db = -5
		SoundManager.play_clip(sound_player, SoundManager.SOUND_JUMP)
		_can_double_jump = false

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func get_jump_dust_position() -> Vector2:
	return Vector2(global_position.x, global_position.y + 15)


func calculate_states() -> void:
	if _state == PLAYER_STATE.HURT:
		return
		
	if is_on_floor() == true:
		if velocity.x == 0:
			set_state(PLAYER_STATE.IDLE)
		else:
			set_state(PLAYER_STATE.RUN)
	else:
		if velocity.y > 0:
			set_state(PLAYER_STATE.FALL)
		else:
			set_state(PLAYER_STATE.JUMP)


func set_state(new_state: PLAYER_STATE) -> void:
	if new_state == _state:
		return
		
	if _state == PLAYER_STATE.FALL:
		if new_state == PLAYER_STATE.IDLE or new_state == PLAYER_STATE.RUN:
			sound_player.volume_db = 8
			SoundManager.play_clip(sound_player, SoundManager.SOUND_LAND)
	
	_state = new_state
	
	match _state:
		PLAYER_STATE.IDLE:
			animation_player.play("idle")
		PLAYER_STATE.RUN:
			animation_player.play("run")
		PLAYER_STATE.JUMP:
			animation_player.play("jump")
		PLAYER_STATE.FALL:
			animation_player.play("fall")
		PLAYER_STATE.HURT:
			apply_hurt_jump()


func go_invincible() -> void:
	_invincible = true
	animation_player_invincible.play("invincible")
	invincible_timer.start()


func reduce_lives() -> bool:
	PlayerVariables.set_lives(PlayerVariables.get_lives(player_number)-1, player_number)
	SignalManager.on_player_hit.emit()
	
	if PlayerVariables.get_lives(player_number) <= 0:
		if PlayerVariables.check_game_over():
			SignalManager.on_game_over.emit()
		set_physics_process(false)
		hide()
		global_position.x = PLAYER_START_POSITION_X
		global_position.y = PLAYER_START_POSITION_Y
		return false
	return true


func apply_hurt_jump() -> void:
	animation_player.play("hurt")
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()


func apply_hit() -> void:
	if _invincible == true:
		return
	
	if reduce_lives() == false:
		return
		
	go_invincible()
	set_state(PLAYER_STATE.HURT)
	SoundManager.play_clip(sound_player, SoundManager.SOUND_DAMAGE)


func retake_damage() -> void:
	for area in hit_box.get_overlapping_areas():
		if area.is_in_group("Dangers") == true:
			apply_hit()
			break
		return


func _on_hit_box_area_entered(_area):
	#print("player hit")
	apply_hit()


func _on_invincible_timer_timeout():
	_invincible = false
	animation_player_invincible.stop()
	retake_damage()


func _on_hurt_timer_timeout():
	set_state(PLAYER_STATE.IDLE)


func _on_screen_exited():
	fallen_off() 


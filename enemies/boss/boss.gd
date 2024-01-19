extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"
const HIT_CONDITION: String = "parameters/conditions/on_hit"

@onready var animation_tree = $AnimationTree
@onready var visual = $Visual
@onready var hit_box = $Visual/HitBox
@onready var boss_hit = $BossHit
@onready var boss_exploded = $Visual/BossExploded
@onready var sprite_2d = $Visual/Sprite2D
@onready var boss_arrival = $BossArrival
@onready var boss_death = $BossDeath
@onready var player_cam = $"../../PlayerCam"

@export var lives: int = 2
@export var points: int = 5

var _invincible: bool = false
var _has_triggered: bool = false


func tween_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, 1.0)


func reduce_lives() -> void:
	SoundManager.play_clip(boss_hit, SoundManager.SOUND_BOSS_HIT)
	lives -= 1
	if lives <= 0:
		SoundManager.play_clip(boss_death, SoundManager.SOUND_BOSS_DEATH)
		boss_exploded.visible = true
		sprite_2d.visible = false	
		boss_exploded.play("boss_exploded")
		hit_box.global_position.y += 200
		SignalManager.on_boss_killed.emit(points)
		kill_all_enemies()


func kill_all_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.queue_free()


func take_damage() -> void:
	if _has_triggered == false:
		return
	
	if _invincible == true:
		return
		
	set_invincible(true)
	tween_hit()
	reduce_lives()


func set_invincible(v: bool) -> void:
	_invincible = v
	animation_tree[HIT_CONDITION] = v


func _on_trigger_area_entered(_area):
	SoundManager.play_clip(boss_arrival, SoundManager.SOUND_BOSS_ARRIVE)
	if animation_tree[TRIGGER_CONDITION] == false:
		animation_tree[TRIGGER_CONDITION] = true
		_has_triggered = true
		hit_box.collision_layer = 4


func _on_hit_box_area_entered(_area):
	take_damage()


func _on_boss_exploded_animation_finished():
	SignalManager.on_boss_explosion_finished.emit()
	queue_free()

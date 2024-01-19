extends Node

enum BULLET_KEY { PLAYER, ENEMY }

enum SCENE_KEY { EXPLOSION, PICKUP, BOSS_EXPLOSION, LIFE_PICKUP, ITEM_PICKUP, JUMP_SMOKE, DOUBLE_JUMP_SMOKE, SPEED_DUST, BOUNDRY }

const BULLETS = {
	BULLET_KEY.PLAYER: preload("res://bullets/bullet_player/bullet_player.tscn"),
	BULLET_KEY.ENEMY: preload("res://bullets/bullet_enemy/bullet_enemy.tscn")
}

const SIMPLE_SCENES = {
	SCENE_KEY.BOUNDRY: preload("res://boundry/boundry.tscn"),
	SCENE_KEY.JUMP_SMOKE: preload("res://jump_smoke/jump_smoke.tscn"),
	SCENE_KEY.EXPLOSION: preload("res://enemy_explosion/enemy_exposion.tscn"),
	SCENE_KEY.BOSS_EXPLOSION: preload("res://enemy_explosion/boss_explosion.tscn"),
	SCENE_KEY.PICKUP: preload("res://fruit_pick_up/fruit_pick_up.tscn"),
	SCENE_KEY.LIFE_PICKUP: preload("res://life_pick_up/life_pick_up.tscn"),
	SCENE_KEY.ITEM_PICKUP: preload("res://item_pickup/item_pickup.tscn"),
	SCENE_KEY.DOUBLE_JUMP_SMOKE: preload("res://jump_smoke/double_jump_smoke.tscn"),
	SCENE_KEY.SPEED_DUST: preload("res://dust_effect/speed_dust.tscn")
}


func add_child_deffered(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deffered", child_to_add)


func create_bullet(speed: float, direction: Vector2, life_span: float,
				key: BULLET_KEY, start_position: Vector2) -> void:
	var new_bullet = BULLETS[key].instantiate()
	new_bullet.setup(direction, life_span, speed)
	new_bullet.global_position = start_position
	call_add_child(new_bullet)


func create_simple_scene( start_position: Vector2, key: SCENE_KEY) -> void:
	var new_scene = SIMPLE_SCENES[key].instantiate()
	new_scene.global_position = start_position
	call_add_child(new_scene)








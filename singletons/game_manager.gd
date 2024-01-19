extends Node


const GROUP_PLAYER: String = "player"
const TOTAL_LEVELS : int = 4
const MAIN_SCENE: PackedScene = preload("res://main/main.tscn")
enum DIFFICULTY_KEYS {EASY, NORMAL, HARD}

var current_level: int = 0
var _level_scenes = {}
var player_2 : bool = false
var _actual_diff : DIFFICULTY_KEYS = DIFFICULTY_KEYS.NORMAL

var _difficult_heart_drop = {
	DIFFICULTY_KEYS.EASY : 0.1,
	DIFFICULTY_KEYS.NORMAL : 0.05,
	DIFFICULTY_KEYS.HARD : 0.0,
}

var _difficult_lives = {
	DIFFICULTY_KEYS.EASY : 15,
	DIFFICULTY_KEYS.NORMAL : 10,
	DIFFICULTY_KEYS.HARD : 5,
}

func _ready():
	init_level_scenes()
	ScoreManager.reset_score()


func init_level_scenes() -> void:
	#_level_scenes[1] = load("res://level_base/levels/level_test.tscn")
	for level_number in range(1, TOTAL_LEVELS + 1):
		_level_scenes[level_number] = load("res://level_base/levels/level_%s.tscn" % level_number)


func load_main_scene() -> void:
	current_level = 0
	#PlayerVariables.player_lives = 5
	ScoreManager.reset_score()
	get_tree().change_scene_to_packed(MAIN_SCENE)	


func load_next_level_scene() -> void:
	set_next_level()
	get_tree().change_scene_to_packed(_level_scenes[current_level])


func set_next_level() -> void:
	current_level += 1
	if current_level > TOTAL_LEVELS:
		current_level = 1


func set_player_2(new_set: bool) -> void:
	player_2 = new_set


func get_player_2() -> bool:
	return player_2


func set_difficulty(difficulty: DIFFICULTY_KEYS) -> void:
	_actual_diff = difficulty


func get_perc_heart() -> float:
	return _difficult_heart_drop[_actual_diff]


func get_initial_lifes() -> int:
	return _difficult_lives[_actual_diff]

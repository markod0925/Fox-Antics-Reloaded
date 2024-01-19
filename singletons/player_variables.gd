extends Node

var player_lives : Dictionary = {
	1: 0,
	2: 0,
}


func set_lives(value: int, player_num: int) -> void:
	player_lives[player_num] = value
	

func get_lives(player_num: int) -> int:
	return player_lives[player_num]
	

func check_game_over() -> bool:
	var game_over : bool = true
	for player in player_lives:
		game_over = game_over and (player_lives[player] <= 0)
	return game_over


func set_start_values(value: int) -> void:
	player_lives[1] = value
	if GameManager.get_player_2():
		player_lives[2] = value
	else:
		player_lives[2] = 0


func inc_lives() -> void:
	player_lives[1] += 1
	if GameManager.get_player_2():
		player_lives[2] += 1

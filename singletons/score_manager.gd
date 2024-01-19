extends Node

const HS_FILE: String = "user://SCORES.dat"
const HS_KEY: String = "highscore"

var _score: int = 0
var _gems_score: int = 0
var _coins_score: int = 0
var _high_score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	load_highscore()
	SignalManager.on_enemy_hit.connect(on_enemy_hit) 
	SignalManager.on_boss_killed.connect(on_boss_killed)
	SignalManager.on_pickup_hit.connect(on_pickup_hit)
	SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_coin_picked_up.connect(update_coins_score)
	SignalManager.on_gem_picked_up.connect(update_gems_score)


func on_level_complete() -> void:
	save_highscore()
	PlayerVariables.inc_lives()


func update_coins_score() -> void:
	_coins_score += 1
	

func update_gems_score() -> void:
	_gems_score += 1


func get_coins_score() -> int:
	return _coins_score


func get_gems_score() -> int:
	return _gems_score


func on_game_over() -> void:
	save_highscore()
	_gems_score = 0
	_coins_score = 0
	#PlayerVariables.player_lives = 5


func on_enemy_hit(points: int, _v: Vector2) -> void:
	update_score(points)


func on_boss_killed(points: int) -> void:
	update_score(points)

	SignalManager.on_game_complete.emit()


func on_pickup_hit(points: int) -> void:
	update_score(points)


func update_score(points: int) -> void:
	_score += points
	
	if _high_score < _score:
		_high_score = _score
	#print("update_score:", _score)
	SignalManager.on_score_updated.emit()

func get_score() -> int:
	return _score


func get_highscore() -> int:
	return _high_score


func reset_score() -> void:
	_score = 0


func save_highscore() -> void:
	var file = FileAccess.open(HS_FILE, FileAccess.WRITE)
	var data = {
		HS_KEY: _high_score
	}
	
	file.store_string(JSON.stringify(data))
	#print("Saved highscore:", data)


func load_highscore() -> void:
	if !FileAccess.file_exists(HS_FILE):
		return
		
	var file = FileAccess.open(HS_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text()) 
	
	#print("data:", data)
	
	if HS_KEY in data:
		_high_score = data[HS_KEY]
		#print("loaded high score:", _high_score)









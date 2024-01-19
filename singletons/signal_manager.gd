extends Node

signal on_enemy_hit(points: int, enemy_position: Vector2) 
signal on_pickup_hit(points: int)
signal on_boss_killed(points: int)
signal on_player_hit
signal on_life_star_picked_up
signal on_gem_picked_up
signal on_coin_picked_up
signal on_level_complete
signal on_game_over
signal on_score_updated
signal on_level_start
signal on_game_complete
signal player_physics
signal on_boss_explosion_finished
signal on_earh_rumble_sound_finished
signal on_game_complete_sound_finished
signal get_life_stars(stars: int)
signal get_coins(coins: int)
signal get_gems(gems: int)

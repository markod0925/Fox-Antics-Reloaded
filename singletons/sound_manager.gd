extends Node

const SOUND_LASER = "laser"
const SOUND_CHECKPOINT = "checkpoint"
const SOUND_DAMAGE = "damage"
const SOUND_KILL = "kill"
const SOUND_IMPACT = "impact"
const SOUND_LAND = "land"
const SOUND_LEVEL_COMPLETE = "level_complete"
const SOUND_PICKUP = "pickup"
const SOUND_BOSS_ARRIVE = "boss_arrive"
const SOUND_BOSS_HIT = "boss_hit"
const SOUND_BOSS_DEATH = "boss_death"
const SOUND_JUMP = "jump"
const SOUND_COIN = "coin"
const SOUND_GEM = "gem"
const SOUND_FALL = "fall"
const SOUND_ENEMY_HIT = "enemy_hit"
const SOUND_BALL_SPIKES_SPIN = "ball_spike_spin"
const SOUND_CIRCULAR_SAW = "circular_saw"
const SOUND_MOVING_PLATFORM = "moving_platform"
const SOUND_FRUIT_BITE = "fruit_bite"
const SOUND_LIFE_STAR = "life_star"
const SOUND_MAIN_MENU = "main-menu"
const SOUND_LEVEL_1 = "level_1"
const SOUND_LEVEL_2 = "level_2"
const SOUND_LEVEL_3 = "level_3"
const SOUND_LEVEL_4 = "level_4"
const SOUND_BEE_BUZZ = "bee_buzz"
const SOUND_EARTH_RUMBLE = "earth_rumble"
const SOUND_EARTH_RUMBLE_LONG = "earth_rumble_long"
const SOUND_WATERFALL = "waterfall"
const SOUND_GAME_COMPLETE = "game_complete"
const SOUND_LEVEL_WIN = "level_win"
const SOUND_GAMEOVER = "game_over"
const SOUND_EAGLE_CRY = "eagle_cry"
const SOUND_BLUE_BIRD = "blue_bird"
const SOUND_FROG_JUMP = "frog_jump"
const SOUND_STONE_SCRAPE = "stone_scrape"
const SOUND_SPEED_BOOST = "speed_boost"


var SOUNDS = {
	SOUND_EARTH_RUMBLE: preload("res://assets/sound/earth-rumble.ogg"),
	SOUND_WATERFALL: preload("res://assets/sound/waterfall.mp3"),
	SOUND_EARTH_RUMBLE_LONG: preload("res://assets/sound/earth-rumble-8s.ogg"),
	SOUND_GAME_COMPLETE: preload("res://assets/sound/game_complete.mp3"),
	SOUND_MAIN_MENU: preload("res://assets/sound/main_menu.ogg"),
	SOUND_LEVEL_1: preload("res://assets/sound/level_1.ogg"),
	SOUND_LEVEL_2: preload("res://assets/sound/level_2.ogg"),
	SOUND_LEVEL_3: preload("res://assets/sound/level_3.ogg"),
	SOUND_LEVEL_4: preload("res://assets/sound/level_4.ogg"),
	SOUND_LIFE_STAR: preload("res://assets/sound/life_star.mp3"),
	SOUND_CHECKPOINT: preload("res://assets/sound/checkpoint.wav"),
	SOUND_DAMAGE: preload("res://assets/sound/damage.wav"),
	SOUND_KILL: preload("res://assets/sound/pickup5.ogg"),
	SOUND_GAMEOVER: preload("res://assets/sound/game-over.mp3"),
	SOUND_IMPACT: preload("res://assets/sound/impact.wav"),
	SOUND_JUMP: preload("res://assets/sound/jump.wav"),
	SOUND_LAND: preload("res://assets/sound/land.wav"),
	SOUND_LASER: preload("res://assets/sound/laser.wav"),
	SOUND_LEVEL_COMPLETE: preload("res://assets/sound/level_complete.mp3"),
	SOUND_LEVEL_WIN: preload("res://assets/sound/level-win.ogg"),
	SOUND_PICKUP: preload("res://assets/sound/pickup5.ogg"),
	SOUND_SPEED_BOOST: preload("res://assets/sound/speed-boost.mp3"),
	SOUND_BOSS_ARRIVE: preload("res://assets/sound/boss_roar.wav"),
	SOUND_BOSS_HIT: preload("res://assets/sound/boss_hit.wav"),
	SOUND_BOSS_DEATH: preload("res://assets/sound/boss_death.wav"),
	SOUND_BALL_SPIKES_SPIN: preload("res://assets/sound/ball_spike_spin.ogg"),
	SOUND_STONE_SCRAPE: preload("res://assets/sound/stone-scrape.ogg"),
	SOUND_CIRCULAR_SAW: preload("res://assets/sound/saw.ogg"),
	SOUND_MOVING_PLATFORM: preload("res://assets/sound/platform-sound.ogg"),
	SOUND_COIN: preload("res://assets/sound/coin_pickup.mp3"),
	SOUND_GEM: preload("res://assets/sound/gem_pickup.wav"),
	SOUND_FRUIT_BITE: preload("res://assets/sound/fruit_bite.mp3"),
	SOUND_FALL: preload("res://assets/sound/fall_sound.wav"),
	SOUND_ENEMY_HIT: preload("res://assets/sound/impact.wav"),
	SOUND_BEE_BUZZ: preload("res://assets/sound/bee_buzz.mp3"),
	SOUND_EAGLE_CRY: preload("res://assets/sound/eagle_scream.mp3"),
	SOUND_BLUE_BIRD: preload("res://assets/sound/blue-bird.mp3"),
	SOUND_FROG_JUMP: preload("res://assets/sound/frog-jump.mp3")
}


func play_clip(player: AudioStreamPlayer2D, clip_key: String):
	if SOUNDS.has(clip_key) == false:
		return
	player.stream = SOUNDS[clip_key]
	player.play()

extends Area2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"


@onready var animation_tree = $AnimationTree
@onready var sound = $Sound
@onready var flag_arrival = $FlagArrival

var player_scene: PackedScene = preload("res://player/player.tscn")

func _ready():
	animation_tree[TRIGGER_CONDITION] = true

func _on_area_entered(_area):
	SignalManager.on_level_complete.emit()


func _on_flag_arrival_timeout():
	animation_tree[TRIGGER_CONDITION] = true
	monitoring = true

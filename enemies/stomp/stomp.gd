extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_detector = $PlayerDetector

@onready var shooter = $Shooter


func _physics_process(delta):
	super._physics_process(delta)
	shoot()


func shoot() -> void:
	if player_detector.is_colliding() == true:
		shooter.shoot(global_position.direction_to(_player_ref.global_position))

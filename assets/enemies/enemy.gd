extends Node3D

signal enemy_exited()

@onready var stats_component := $StatsComponent as StatsComponent
@onready var move_component := $MoveComponent as MoveComponent
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var flash_component := $FlashComponent as FlashComponent
@onready var shake_component := $ShakeComponent as ShakeComponent
@onready var hitbox_component := $HitboxComponent as HitboxComponent
@onready var hurtbox_component := $HurtboxComponent as HurtboxComponent


func _ready():
	enemy_exited.connect(queue_free)


func _process(delta):
	if global_position.z > 5:
		enemy_exited.emit()
		
	hurtbox_component.hurt.connect(func():
		queue_free()
	)

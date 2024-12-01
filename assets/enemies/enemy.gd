class_name Enemy
extends Node3D

signal enemy_exited()

@onready var stats_component := $StatsComponent as StatsComponent
@onready var move_component := $MoveComponent as MoveComponent
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var flash_component := $FlashComponent as FlashComponent
@onready var shake_component := $ShakeComponent as ShakeComponent
@onready var hitbox_component := $HitboxComponent as HitboxComponent
@onready var hurtbox_component := $HurtboxComponent as HurtboxComponent
@onready var destroyed_component := $DestroyedComponent as DestroyedComponent
@onready var score_component := $ScoreComponent as ScoreComponent


func _ready():
	stats_component.no_health.connect(func():
		score_component.adjust_score()
	)
	
	enemy_exited.connect(queue_free)
		
	hurtbox_component.hurt.connect(func(_hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		shake_component.tween_shake()
	)
	stats_component.no_health.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))


func _process(_delta):
	if global_position.z > 5:
		enemy_exited.emit()

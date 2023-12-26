extends Node3D

@onready var left_muzzle := $LeftMuzzle as Marker3D
@onready var right_muzzle := $RightMuzzle as Marker3D
@onready var spawner_component := $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer := $FireRateTimer as Timer
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var move_component := $MoveComponent as MoveComponent
@onready var sprite_mesh_instance := $SpriteMeshInstance as SpriteMeshInstance
@onready var animation_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers) 


func fire_lasers() -> void:
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()


func _process(delta):
	animate_the_ship()


func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animation_player.play("Left")
	elif move_component.velocity.x > 0:
		animation_player.play("Right")
	else:
		animation_player.play("Idle")

class_name Ship
extends Node3D

@onready var left_muzzle := $LeftMuzzle as Marker3D
@onready var right_muzzle := $RightMuzzle as Marker3D
@onready var spawner_component := $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer := $FireRateTimer as Timer
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var move_component := $MoveComponent as MoveComponent
@onready var move_input_component := $MoveInputComponent as MoveInputComponent
@onready var sprite_mesh_instance := $SpriteMeshInstance as SpriteMeshInstance
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var left_button := %LeftButton as Button
@onready var right_button := %RightButton as Button

var left_velocity := 0.0
var right_velocity := 0.0


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers) 
	
	left_button.pressed.connect(func():
		move_input_component.use_keys = false
		left_velocity = 1
		move_component.velocity = Vector3(
			(right_velocity - left_velocity) * move_input_component.move_stats.speed, 0, 0)
	)
	right_button.pressed.connect(func():
		move_input_component.use_keys = false
		right_velocity = 1
		move_component.velocity = Vector3(
			(right_velocity - left_velocity) * move_input_component.move_stats.speed, 0, 0)
	)
	left_button.button_up.connect(func():
		move_input_component.use_keys = true
		left_velocity = 0
		move_component.velocity = Vector3(
			(right_velocity - left_velocity) * move_input_component.move_stats.speed, 0, 0)
	)
	right_button.button_up.connect(func():
		move_input_component.use_keys = true
		right_velocity = 0
		move_component.velocity = Vector3(
			(right_velocity - left_velocity) * move_input_component.move_stats.speed, 0, 0)
	)


func fire_lasers() -> void:
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()


func _process(_delta):
	animate_the_ship()


func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animation_player.play("Left")
	elif move_component.velocity.x > 0:
		animation_player.play("Right")
	else:
		animation_player.play("Idle")

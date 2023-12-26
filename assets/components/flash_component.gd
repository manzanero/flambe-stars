class_name FlashComponent
extends Node

const FLASH_MATERIAL = preload("res://resources/galaxy_defiance/effects/white_flash_material.tres")

@export var sprite: MeshInstance3D
@export var flash_duration: = 0.2

var original_sprite_material: Material
var timer: Timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	original_sprite_material = sprite.get_surface_override_material(0)

func flash():
	sprite.set_surface_override_material(0, FLASH_MATERIAL)
	timer.start(flash_duration)
	await timer.timeout
	sprite.set_surface_override_material(0, original_sprite_material)

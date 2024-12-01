class_name PositionClampComponent
extends Node

@export var actor: Node3D
@export var sep := 8

func _process(_delta: float) -> void:
	actor.global_position.x = clamp(actor.global_position.x, -sep, sep)

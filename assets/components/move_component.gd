class_name MoveComponent
extends Node

@export var actor: Node3D
@export var velocity: Vector3


func _process(delta: float) -> void:
	actor.translate(velocity * delta)

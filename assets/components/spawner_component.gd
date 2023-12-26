class_name SpawnerComponent
extends Node3D

@export var scene: PackedScene


func spawn(global_spawn_position: Vector3 = global_position, parent: Node = get_tree().current_scene) -> Node:
	assert(scene is PackedScene)
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = global_spawn_position
	return instance

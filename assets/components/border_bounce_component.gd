# Give the component a class name so it can be instanced as a custom node
class_name BorderBounceComponent
extends Node

# The margin is used to allow actors to bounce before reaching the edge of the border
@export var margin: = 8

# Export the actor that this component will operate on
@export var actor: Node3D

# We need to grab the move component of the actor in order to change its velocity when bouncing
@export var move_component: MoveComponent

# Define the left and right borders to bounce on
var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

func _process(_delta: float) -> void:
	if actor.global_position.x < -margin:
		actor.global_position.x = -margin
		move_component.velocity = move_component.velocity.bounce(Vector3.RIGHT)
		
	elif actor.global_position.x > margin:
		actor.global_position.x = margin
		move_component.velocity = move_component.velocity.bounce(Vector3.LEFT)
	

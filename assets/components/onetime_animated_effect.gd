class_name OnetimeAnimatedEffect
extends AnimationPlayer


@export var parent: Node3D


func _ready() -> void:
	animation_finished.connect(parent.queue_free.unbind(1))

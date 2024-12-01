extends Node3D

@onready var visibility_timer := $VisibilityTimer as Timer
@onready var hitbox_component := $Anchor/HitboxComponent as HitboxComponent
@onready var scale_component := $ScaleComponent as ScaleComponent


func _ready():
	visibility_timer.timeout.connect(queue_free)
	scale_component.tween_scale()
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))

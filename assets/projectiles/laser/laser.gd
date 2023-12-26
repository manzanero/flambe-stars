extends Node3D

@onready var visibility_timer := $VisibilityTimer as Timer
@onready var scale_component := $ScaleComponent as ScaleComponent
@onready var flash_component := $FlashComponent as FlashComponent


func _ready():
	scale_component.tween_scale()
	flash_component.flash()
	visibility_timer.timeout.connect(queue_free)

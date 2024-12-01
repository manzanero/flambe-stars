extends Enemy


func _ready():
	super()
	move_component.velocity.x = [-10, 10].pick_random()

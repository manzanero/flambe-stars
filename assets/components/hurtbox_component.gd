class_name HurtboxComponent
extends Area3D

signal hurt(hitbox)

var is_invincible = false :
	set(value):
		is_invincible = value
		for child in get_children():
			if child is CollisionShape3D or child is CollisionPolygon3D: 
				child.set_deferred("disabled", is_invincible)



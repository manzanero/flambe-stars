class_name MainMenu
extends Control


signal game_starts()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and visible:
		visible = false
		game_starts.emit()


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and visible:
			visible = false
			game_starts.emit()

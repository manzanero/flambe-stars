class_name GameOver
extends Control

signal game_retry()

@export var game_stats: GameStats

@onready var score_value_label := %ScoreValueLabel as Label
@onready var high_score_value_label := %HighScoreValueLabel as Label


func update_score():
	score_value_label.text = str(game_stats.score)
	high_score_value_label.text = str(game_stats.highscore)


func _input(event):
	if Input.is_action_just_pressed("ui_accept") and visible:
		game_stats.score = 0
		visible = false
		game_retry.emit()
		
	if event is InputEventMouseButton:
		if event.pressed and visible:
			game_stats.score = 0
			visible = false
			game_retry.emit()

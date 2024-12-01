class_name GameStats
extends Resource

signal score_changed()

@export var score: int = 0 :
	set(value):
		score = value
		if highscore < value:
			highscore = value
			
		score_changed.emit()
		
@export var highscore: int = 0

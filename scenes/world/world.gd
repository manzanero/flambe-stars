extends Node3D

@export var game_stats: GameStats

var ship: Ship = null
var move := false
var move_dir := false

@onready var enemy_generator := $EnemyGenerator as EnemyGenerator
@onready var spawner_component := $SpawnerComponent as SpawnerComponent
@onready var score_label := %ScoreLabel as Label
@onready var main_menu := %MainMenu as MainMenu
@onready var game_over := %GameOver as GameOver
@onready var audio_stream_player := %AudioStreamPlayer as AudioStreamPlayer
@onready var music_slider := %MusicSlider as VSlider


func _ready():
	randomize()
	audio_stream_player.finished.connect(audio_stream_player.play)
	audio_stream_player.volume_db = linear_to_db(music_slider.value ** 2)
	update_score_label()
	game_stats.score_changed.connect(update_score_label)
	music_slider.drag_ended.connect(func(_value_changed: bool):
		audio_stream_player.volume_db = linear_to_db(music_slider.value ** 2)
	)
	main_menu.game_starts.connect(game_starts)
	game_over.game_retry.connect(game_starts)


func game_starts():
	if not is_instance_valid(ship):
		ship = spawner_component.spawn(Vector3.ZERO)
		ship.tree_exited.connect(game_ends)
		
	score_label.visible = true
	enemy_generator.active = true


func game_ends():
	if not is_instance_valid(get_tree()):
		return
		
	await get_tree().create_timer(2).timeout
	game_over.update_score()
	game_over.visible = true
	score_label.visible = false
	enemy_generator.active = false
	
	for enemy in get_tree().get_nodes_in_group('enemies'):
		enemy.destroyed_component.destroy()


func update_score_label() -> void:	
	score_label.text = "Highscore\n%s\nScore\n%s" % [game_stats.highscore, game_stats.score]

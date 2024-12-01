class_name EnemyGenerator
extends Node3D

const green_enemy := preload("res://assets/enemies/green_enemy/green_enemy.tscn")
const yellow_enemy := preload("res://assets/enemies/yellow_enemy/yellow_enemy.tscn")
const pink_enemy := preload("res://assets/enemies/pink_enemy/pink_enemy.tscn")

var active := false

@export var game_stats: GameStats
@export var margin := 8

@onready var spawner_component := $SpawnerComponent as SpawnerComponent
@onready var green_enemy_timer := $GreenEnemyTimer as Timer
@onready var yellow_enemy_timer := $YellowEnemyTimer as Timer
@onready var pink_enemy_timer := $PinkEnemyTimer as Timer


func _ready():
	green_enemy_timer.timeout.connect(handle_spawn.bind(green_enemy, green_enemy_timer))
	yellow_enemy_timer.timeout.connect(handle_spawn.bind(yellow_enemy, yellow_enemy_timer, 5))
	pink_enemy_timer.timeout.connect(handle_spawn.bind(pink_enemy, pink_enemy_timer, 7))
	
	game_stats.score_changed.connect(func():
		if game_stats.score > 10:
			yellow_enemy_timer.process_mode = Node.PROCESS_MODE_INHERIT
		if game_stats.score > 50:
			pink_enemy_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)
	

func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	if active:
		spawner_component.scene = enemy_scene
		spawner_component.spawn(Vector3(randf_range(-margin, margin), 0 , -50))
	
	var spawn_rate = time_offset / (0.5 + (game_stats.score * 0.01)) 
	timer.start(spawn_rate + randf_range(0.25, 0.5))

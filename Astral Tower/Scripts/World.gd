extends Node2D
var enemy_scene = preload("res://Scenes/Enemy.tscn")

func _ready():
	
	enemy_scene.connect("enemy_defeated", $Score/ScoreValue, "_on_enemy_killed")
	
	randomize()
	
	$EnemySpawnTimer.start()

func _on_EnemySpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	
	var enemy_spawn_location = get_node("EnemySpawner/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	

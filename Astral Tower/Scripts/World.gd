extends Node2D
var enemy_scene = preload("res://Scenes/Enemy.tscn")

func _ready():
	randomize()
	$EnemySpawnTimer.start()
	$Player.connect("dmg_player", $Player, "_damaged")
	$DeathZone.connect("dmg_player", $Player, "_damaged")
	$DeathZone.connect("body_entered", $DeathZone, "_on_body_entered")

func _on_EnemySpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	enemy.connect("enemy_defeated", $Score/ScoreValue, "_on_enemy_killed")
	
	var enemy_spawn_location = get_node("EnemySpawner/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	

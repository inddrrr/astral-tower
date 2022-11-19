extends Node2D
var enemy_scene = preload("res://Scenes/Enemy.tscn")

signal enemy_defeated
var enemy_count: int = 0
var score: int = 0

func _ready():
	randomize()
	$DeathZone.connect("dmg_player", $Player, "_damaged")
	$DeathZone.connect("body_entered", $DeathZone, "_on_body_entered")
	
	$EnemySpawnTimer.start()

func _on_EnemySpawnTimer_timeout():
	var max_enemy_on_screen = int(max(self.score/5, 10))
	if self.enemy_count >= max_enemy_on_screen:
		return
	
	var enemy = enemy_scene.instance()
	var enemy_spawn_location = get_node("EnemySpawner/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	self.enemy_count += 1
	
func _on_enemy_killed():
	self.enemy_count -= 1
	self.score += 1
	$Score/ScoreValue.set_score(self.score)

extends Node2D
var enemy_scene = preload("res://Scenes/Gameplay/Enemy.tscn")
var game_over_scene = preload("res://Scenes/Gameplay/GameOver.tscn")

var enemy_count: int = 0
var score: int = 0

signal update_player_health

func _ready():
	randomize()
	$DeathZone.connect("dmg_player", $Player, "_damaged")
	$DeathZone.connect("body_entered", $DeathZone, "_on_body_entered")
	
	$EnemySpawnTimer.start()
	self._update_player_health()

func _process(delta):
	_update_player_health()

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
	self._on_enemy_despawned()
	self.score += 1
	$HUD/Score/ScoreValue.set_score(self.score)

func _on_enemy_despawned():
	self.enemy_count -= 1

func _update_player_health():
	if $Player != null:
		$HUD/Health/HealthValue.set_health($Player.hp, $Player.max_health)

func game_over():
	var game_over_node = game_over_scene.instance()
	add_child(game_over_node)
	get_node("GameOver/MarginContainer/VBoxContainer/ScoreValue").set_score(self.score)
	get_tree().paused = true

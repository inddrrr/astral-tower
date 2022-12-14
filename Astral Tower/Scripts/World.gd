extends Node2D
var enemy_scene = preload("res://Scenes/Gameplay/Enemy.tscn")
var game_over_scene = preload("res://Scenes/Gameplay/GameOver.tscn")

var enemy_count: int = 0
var score: int = 0

signal instant_boost

func _ready():
	randomize()
	if $DeathZone.connect("dmg_player", $Player, "_damaged") != 0:
		print("failed connecting DeathZone to dmg_player")
		
	if $DeathZone.connect("body_entered", $DeathZone, "_on_body_entered") != 0:
		print("failed connecting DeathZone to body_entered")
	
	$EnemySpawnTimer.start()
	self._update_player_health()
	
	$NewGameSound.play()

func _process(_delta):
	_update_player_health()
	if $BGM.playing == false:
		$BGM.play()

func _on_EnemySpawnTimer_timeout():
	var max_enemy_on_screen = ceil(max(self.score/5.0, 3))
	if self.enemy_count >= max_enemy_on_screen:
		return
	
	var enemy = enemy_scene.instance()
	var enemy_spawn_location = get_node("EnemySpawner/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
	
	if self.connect("instant_boost", enemy, "instant_boost"):
		print("failed connecting Enemy to instant_boost")
		
	self.enemy_count += 1
	
func _on_enemy_killed():
	self.enemy_count -= 1
	self.score += 1
	$HUD/Score/ScoreValue.set_score(self.score)

func _on_enemy_despawned():
	self.enemy_count -= 1
	self.emit_signal("instant_boost")

func _update_player_health():
	if $Player != null:
		$HUD/Health/HealthValue.set_health($Player.hp, $Player.max_health)

func game_over():
	_update_player_health()
	var game_over_node = game_over_scene.instance()
	add_child(game_over_node)
	get_node("GameOver/MarginContainer/VBoxContainer/ScoreValue").set_score(self.score)
	get_tree().paused = true

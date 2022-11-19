extends Node2D
var enemy_scene = preload("res://Scenes/Enemy.tscn")

var enemy_count: int = 0
var score: int = 0

signal update_player_health

func _ready():
	randomize()
	$Gameplay/DeathZone.connect("dmg_player", $Gameplay/Player, "_damaged")
	$Gameplay/DeathZone.connect("body_entered", $Gameplay/DeathZone, "_on_body_entered")
	
	$Gameplay/EnemySpawnTimer.start()
	self._update_player_health()

func _process(delta):
	_update_player_health()

func _on_EnemySpawnTimer_timeout():
	var max_enemy_on_screen = int(max(self.score/5, 10))
	if self.enemy_count >= max_enemy_on_screen:
		return
	
	var enemy = enemy_scene.instance()
	var enemy_spawn_location = get_node("Gameplay/EnemySpawner/EnemySpawnLocation")
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
	if $Gameplay/Player != null:
		$HUD/Health/HealthValue.set_health($Gameplay/Player.hp, $Gameplay/Player.max_health)

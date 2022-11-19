extends Node2D

func _ready():
	$DummyEnemy.connect("enemy_defeated", $Score/ScoreValue, "on_enemy_killed")

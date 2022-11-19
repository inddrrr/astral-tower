extends Node2D

func _ready():
	$Enemy.connect("enemy_defeated", $Score/ScoreValue, "_on_enemy_killed")

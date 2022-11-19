extends Area2D

export(int) var enemy_speed = 10
export(int) var shooting_interval = 3

onready var BULLET = preload("res://Scenes/EnemyBullet.tscn")
onready var shoot_timer = $Timer

signal enemy_despawned
signal collided_with_player

func _ready():
	var world = self.get_tree().root.get_node("World")
	var player = self.get_tree().root.get_node("World/Gameplay/Player")
	
	self.connect("enemy_despawned", world, "_on_enemy_despawned")
	self.connect("collided_with_player", player, "_damaged")

func _physics_process(delta):
	$AnimatedSprite.playing = true
	position.y += Vector2.UP.y * enemy_speed * delta
	
	if position.y < -20:
		self.emit_signal("enemy_despawned")
		self.queue_free()
	
	if shoot_timer.is_stopped():
		shoot()


func shoot():
	var bullet = BULLET.instance()
	bullet.global_position = Vector2($Position2D.global_position[0], $Position2D.global_position[1]-10)
	get_tree().root.add_child(bullet)
	
	shoot_timer.wait_time = shooting_interval
	shoot_timer.start()


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		self.emit_signal("collided_with_player", 30)
		self.queue_free()

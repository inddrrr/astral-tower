extends Area2D

export(int) var base_speed = 10
export(int) var enemy_speed = 10
export(int) var shooting_interval = 3

onready var BULLET = preload("res://Scenes/Gameplay/EnemyBullet.tscn")
onready var shoot_timer = $Timer

signal enemy_despawned
signal collided_with_player

var world: Node

func _ready():
	self.world = self.get_tree().root.get_node("World")
	var player = self.get_tree().root.get_node("World/Player")
	
	if self.connect("enemy_despawned", self.world, "_on_enemy_despawned") != 0:
		print("failed connecting Enemy to enemy_despawned")
		
	if self.connect("collided_with_player", player, "_damaged") != 0:
		print("failed connecting Enemy to collided_with_player")

func _physics_process(delta):
	if enemy_speed > base_speed and $InstantBoostTimer.is_stopped():
		enemy_speed = base_speed
	
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
	self.world.add_child(bullet)
	
	shoot_timer.wait_time = shooting_interval
	shoot_timer.start()


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		self.emit_signal("collided_with_player", 30)
		self.queue_free()

func instant_boost():
	self.enemy_speed = self.base_speed*10
	$InstantBoostTimer.start()

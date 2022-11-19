extends Area2D

export(int) var enemy_speed = 10
export(int) var shooting_interval = 3

onready var BULLET = preload("res://Scenes/EnemyBullet.tscn")
onready var shoot_timer = $Timer

func _physics_process(delta):
	$AnimatedSprite.playing = true
	position.y += Vector2.UP.y * enemy_speed * delta
	
	if shoot_timer.is_stopped():
		shoot()


func shoot():
	var bullet = BULLET.instance()
	bullet.global_position = Vector2($Position2D.global_position[0], $Position2D.global_position[1]-10)
	get_tree().root.add_child(bullet)
	
	shoot_timer.wait_time = shooting_interval
	shoot_timer.start()

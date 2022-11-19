extends KinematicBody2D

export(int) var gravity = 80
export(int) var speed = 60
export(int) var interval = 1
export(int) var max_health = 100


onready var BULLET = preload("res://Scenes/Bullet.tscn")
onready var shoot_timer = $Timer

var game_over = false
var screen_size = OS.get_screen_size()
var hp = max_health

signal dmg_player

func _physics_process(delta):
	if self.hp == 0:
		return
	
	var velocity: Vector2
	
	# gravity
	velocity.y += gravity
	
	# input direction
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * speed
	
	if position.y > screen_size.y:
		queue_free()
	
	# jump
	if is_on_floor():
		$AnimatedSprite.animation = "Idle"
		if Input.is_action_just_pressed("jump"):
			velocity.y = -2000
	else:
		$AnimatedSprite.animation = "Jump"
		
		if shoot_timer.is_stopped():
			shoot()
	
	# Apply movement
	move_and_slide(velocity, Vector2.UP)

func _damaged(dmg: int):
	self.hp = max(self.hp - dmg, 0)
	if self.hp == 0:
		print("GAME OVER")

func shoot():
	var bullet = BULLET.instance()
	bullet.global_position = Vector2($Position2D.global_position[0], $Position2D.global_position[1]+10)
	get_tree().root.add_child(bullet)
	
	shoot_timer.wait_time = interval
	shoot_timer.start()


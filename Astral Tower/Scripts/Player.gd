extends KinematicBody2D

export(int) var gravity = 25
export(int) var speed = 40
export(int) var interval = 1

onready var BULLET = preload("res://Scenes/Bullet.tscn")
onready var shoot_timer = $Timer

var game_over = false
var screen_size = OS.get_screen_size()

func _physics_process(delta):
	var velocity: Vector2
	
	# gravity
	velocity.y += gravity
	
	# input direction
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * speed
	
	if position.y > screen_size.y:
		queue_free()
		
	if position.y < 0:
		position.y = 0
	
	
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
	

func shoot():
	var bullet = BULLET.instance()
	bullet.global_position = $Position2D.global_position
	get_tree().root.add_child(bullet)
	
	shoot_timer.wait_time = interval
	shoot_timer.start()


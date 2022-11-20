extends KinematicBody2D

export(int) var gravity = 40
export(int) var speed = 60
export(int) var interval = 1
export(int) var max_health = 100
export(int) var jump_high = -3000


onready var BULLET = preload("res://Scenes/Gameplay/Bullet.tscn")
onready var shoot_timer = $Timer
onready var _animated_sprite: Object = $AnimatedSprite

var game_over = false
var hp = max_health
var player_state = "Idle"
var is_currently_damaged = false
var direction = 1

signal game_over

var world: Node

func _ready():
	self.world = self.get_tree().root.get_node("World")
	if self.connect("game_over", self.world, "game_over") != 0:
		print("failed connecting Player to game_over")
	

func _process(_delta):
	if is_currently_damaged:
		_animated_sprite.play("Damaged")
		is_currently_damaged = false
		yield(_animated_sprite, "animation_finished")
		_animated_sprite.stop()
		
	if not(_animated_sprite.animation == "Damaged" and _animated_sprite.playing):
		_animated_sprite.play(player_state)
	
	if direction > 0:
		if _animated_sprite.flip_h:
			_animated_sprite.flip_h = false
	elif direction < 0: 
		if not _animated_sprite.flip_h:
			_animated_sprite.flip_h = true

func _physics_process(_delta):
	var velocity: Vector2 = Vector2()
	velocity.y += gravity
	
	# input direction
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * speed
	
	if is_on_floor():
		player_state = "Idle"
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_high
		if direction != 0:
			player_state = "Run"
	else:
		player_state = "Jump"
		if shoot_timer.is_stopped():
			shoot()
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2.UP)

func _damaged(dmg: int):
	is_currently_damaged = true
	self.hp = max(self.hp - dmg, 0)
	if self.hp == 0:
		self.emit_signal("game_over")

func shoot():
	var bullet = BULLET.instance()
	bullet.global_position = Vector2($Position2D.global_position[0], $Position2D.global_position[1]+10)
	self.world.add_child(bullet)
	
	shoot_timer.wait_time = interval
	shoot_timer.start()


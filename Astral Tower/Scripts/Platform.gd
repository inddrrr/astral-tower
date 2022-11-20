extends KinematicBody2D

export(int) var speed = 75

var screen_size = OS.get_screen_size()

func _physics_process(_delta):
	$AnimatedSprite.playing = true
	
	# input direction
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	# Apply movement
	# warning-ignore:return_value_discarded
	move_and_slide(direction * speed)
	
	if position.y > screen_size.y:
		position.y = screen_size.y
	elif position.y < 0:
		position.y = 0

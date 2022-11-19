extends Area2D

export(int) var speed = 400
onready var screen_size = OS.get_screen_size()


func _physics_process(delta):
	if position.y > screen_size.y:
		queue_free()
		
	position += transform.y * speed * delta
	


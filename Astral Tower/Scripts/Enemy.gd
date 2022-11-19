extends Area2D

export(int) var enemy_speed = 10


func _physics_process(delta):
	
	$AnimatedSprite.playing = true
	
	position.y += Vector2.UP.y * enemy_speed * delta
	
	


func _on_Enemy_area_entered(area):
	queue_free()

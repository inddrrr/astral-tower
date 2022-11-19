extends Area2D

export(int) var enemy_speed = 10
signal enemy_defeated


func _physics_process(delta):
	$AnimatedSprite.playing = true
	position.y += Vector2.UP.y * enemy_speed * delta


func _on_Enemy_area_entered(area: Area2D):
	if (area.name.begins_with('@Bullet@')):
		print("hit")
		self.queue_free()
		self.emit_signal("enemy_defeated")
		area.queue_free()

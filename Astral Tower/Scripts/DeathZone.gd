extends Area2D

signal dmg_player

# Called when the node enters the scene tree for the first time.

func _on_body_entered(body: Node):
	if (body.name == 'Player'):
		self.emit_signal("dmg_player", 1000)
		body.queue_free()

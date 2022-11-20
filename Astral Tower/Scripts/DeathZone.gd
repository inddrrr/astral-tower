extends Area2D

signal dmg_player

func _on_body_entered(body: Node):
	if (body.name == 'Player'):
		self.emit_signal("dmg_player", 1000)

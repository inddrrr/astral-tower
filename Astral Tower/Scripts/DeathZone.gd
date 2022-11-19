extends Area2D

signal dmg_player

# Called when the node enters the scene tree for the first time.

func _on_body_entered(body: Node):
	print(body.name)
	if (body.name == 'Player'):
		self.emit_signal("dmg_player", 1000)

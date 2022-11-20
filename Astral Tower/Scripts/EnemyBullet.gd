extends Area2D

export(int) var speed = 80

signal dmg_player

func _ready():
	var player = self.get_tree().root.get_node("World/Player")
	if self.connect("dmg_player", player, "_damaged") != 0:
		print("failed connecting EnemyBullet with dmg_player")

func _physics_process(delta):
	if position.y < 0:
		queue_free()
		
	position -= transform.y * speed * delta



func _on_EnemyBullet_body_entered(body):
	if (body.name == 'Player'):
		self.emit_signal("dmg_player", 15)
		self.queue_free()

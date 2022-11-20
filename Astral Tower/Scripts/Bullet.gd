extends Area2D

export(int) var speed = 80
onready var screen_size = OS.get_screen_size()

signal enemy_defeated

func _ready():
	var world = self.get_tree().root.get_node("World")
	if self.connect("enemy_defeated", world, "_on_enemy_killed") != 0:
		print("failed connecting Bullet to enemy_defeated")

func _physics_process(delta):
	if position.y > screen_size.y:
		queue_free()
		
	position += transform.y * speed * delta

func _on_Bullet_area_entered(area):
	if (area.name.begins_with('@Enemy@') or area.name == 'Enemy'):
		area.queue_free()
		self.emit_signal("enemy_defeated")
		self.queue_free()
	elif (area.name == 'DeathZone'):
		self.queue_free()

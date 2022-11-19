extends Area2D

signal enemy_defeated


# Called when the node enters the scene tree for the first time.
func _ready():
	# self.connect("body_entered", self, "_on_area_entered") # if bullet is node
	self.connect("area_entered", self, "_on_area_entered") # if bullet is area


func _on_area_entered(body: Area2D):	
	if (body.name.begins_with('@Bullet@')):
		self.queue_free()
		self.emit_signal("enemy_defeated")


extends Label


var score = 0

func _ready():
	pass

# Called when the node enters the scene tree for the first time.
func _on_enemy_killed():
	score += 1
	text = "%s" % score

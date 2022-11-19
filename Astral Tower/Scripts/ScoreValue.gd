extends Label

signal enemy_defeated

# Called when the node enters the scene tree for the first time.
func set_score(score: int):
	text = "%s" % score

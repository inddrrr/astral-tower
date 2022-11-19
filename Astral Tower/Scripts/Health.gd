extends Label

# Called when the node enters the scene tree for the first time.
func set_health(health: int, max_health: int):
	text = "{health} / {max_health}".format({"health": health, "max_health": max_health})

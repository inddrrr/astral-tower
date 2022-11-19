extends Node2D

func _on_RestartButton_button_up():
	get_tree().reload_current_scene()
	get_tree().paused = false
	self.queue_free()

extends Node2D

func _ready():
	$GameOverSound.play()

func _on_RestartButton_button_up():
	get_tree().reload_current_scene()
	get_tree().paused = false
	self.queue_free()


func _on_HomeButton_button_up():
	if get_tree().change_scene("res://Scenes/MainMenu.tscn") != 0:
		print("failed changing scene from GameOver HomeButton")
	get_tree().paused = false

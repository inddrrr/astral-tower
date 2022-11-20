extends Node2D


func _on_BackButton_button_up():
	if get_tree().change_scene("res://Scenes/MainMenu.tscn") != 0:
		print("failed changing scene from GameOver HomeButton")
	get_tree().paused = false

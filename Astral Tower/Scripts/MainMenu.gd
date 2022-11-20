extends Node2D

export var main_game_scene: PackedScene


func _on_PlayButton_button_up():
	if get_tree().change_scene(main_game_scene.resource_path) != 0:
		print("failed changing scene from MainMenu PlayButton")

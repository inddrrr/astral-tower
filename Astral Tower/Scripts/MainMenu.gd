extends Node2D

export var main_game_scene: PackedScene

var about_us_scene = preload("res://Scenes/AboutUs.tscn")

func _ready():
	$BGM.play()

func _process(_delta):
	if $BGM.playing == false:
		$BGM.play()

func _on_PlayButton_button_up():
	if get_tree().change_scene(main_game_scene.resource_path) != 0:
		print("failed changing scene from MainMenu PlayButton")


func _on_AboutUsButton_button_up():
	var about_us = about_us_scene.instance()
	add_child(about_us)

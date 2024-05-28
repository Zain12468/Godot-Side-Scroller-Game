extends Node

@onready var died = false
@onready var nextLevel = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 1.tscn")



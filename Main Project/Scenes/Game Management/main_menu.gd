# This script extends Node and handles level transitions and player status flags.

extends Node

# Flag indicating if the player has died
@onready var died = false

# Flag indicating if the player is proceeding to the next level
@onready var nextLevel = false

# Function called when the start button is pressed
func _on_start_pressed():
	# Change the current scene to "Level 1"
	get_tree().change_scene_to_file("res://Scenes/Levels/Level 1.tscn")

# This script extends Area2D and handles level transitions when the player enters the area.

extends Area2D

# Export a PackedScene variable for the target level to allow assignment in the editor
@export var target_level : PackedScene

# Function called when a body enters the area
func _on_body_entered(body):
	# Check if the body that entered the area is the player
	if body.name == 'Player':
		# Change the current scene to the target level
		get_tree().change_scene_to_packed(target_level)

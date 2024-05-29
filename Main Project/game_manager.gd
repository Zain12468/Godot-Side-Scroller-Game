# This script extends Node and manages the player's score, updating the UI accordingly.

extends Node

# Cache a reference to the ScoreLabel node in the UI
@onready var point_label = $"../UI/Panel/ScoreLabel"

# Initialize the points variable to 0
var points = 0

# Function to add a point to the player's score
func add_point():
	# Increment the points variable by 1
	points += 1
	
	# Update the text of the point_label to display the new score
	point_label.text = 'Points: ' + str(points)

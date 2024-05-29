# This script extends HBoxContainer and manages the display of hearts representing player health.

extends HBoxContainer

# Preload the HeartGui scene for instantiation
@onready var HeartGuiClass = preload("res://Scenes/Game Management/heart_gui.tscn")

# Function to set the maximum number of hearts displayed
func setMaxHearts(max: int):
	# Instantiate and add 'max' number of hearts as children of this HBoxContainer
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

# Function to update the displayed hearts based on the current health
func updateHearts(CurrentHealth: int):
	# Get all child nodes (hearts) of this HBoxContainer
	var hearts = get_children()
	
	# Loop through hearts up to the current health and update them to show as full
	for i in range(CurrentHealth):
		hearts[i].update(true)
	
	# Loop through the remaining hearts and update them to show as empty
	for i in range(CurrentHealth, hearts.size()):
		hearts[i].update(false)

# This script extends Node and manages the UI elements related to player health and death.

extends Node

# Cache references to important nodes in the scene
@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var player = $"Scene Objects/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the maximum number of hearts in the UI based on the player's maximum health
	heartsContainer.setMaxHearts(player.maxHealth)
	
	# Update the hearts UI to reflect the player's current health
	heartsContainer.updateHearts(player.currentHealth)
	
	# Connect the player's healthChanged signal to the heartsContainer's updateHearts function
	player.healthChanged.connect(heartsContainer.updateHearts)
	
	# If the player has died in the main menu, play the death sound and reset the flag
	if MainMenu.died == true:
		$Death.play()
		MainMenu.died = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # Currently, no per-frame logic is required

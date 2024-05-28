extends Node

@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var player = $"Scene Objects/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	if MainMenu.died == true:
		$Death.play()
		MainMenu.died = false
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


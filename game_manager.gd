extends Node
@onready var point_label = $"../UI/Panel/ScoreLabel"

var points = 0

func add_point():
	points += 1 
	point_label.text = 'Points: ' + str(points)

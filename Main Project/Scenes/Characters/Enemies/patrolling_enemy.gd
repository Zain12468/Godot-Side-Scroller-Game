extends CharacterBody2D


var SPEED = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true
@onready var sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	#Animations
	sprite_2d.animation = 'running'
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
		
		velocity.x = SPEED
		move_and_slide()
		

func flip():
	#Flips the player
	facing_right = !facing_right
	scale.x = abs(scale.x) + -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1
		
	
	
	

	




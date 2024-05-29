# This script extends CharacterBody2D and controls a 2D character's movement and animations.
# The character moves back and forth between two points, and handles collisions and "hurtbox" interactions.

extends CharacterBody2D

# Get the default gravity setting from the project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var startPosition  # Variable to store the starting position of the character
var endPosition  # Variable to store the end position of the character

# Cache a reference to the AnimatedSprite2D node
@onready var sprite_2d = $AnimatedSprite2D

# Speed of the character's movement
@export var speed = 150
# The distance limit to switch directions
@export var limit = 0.5
# An optional endpoint that can be set in the editor
@export var endPoint : Marker2D


# Called when the node is added to the scene
func _ready():
	# Initialize startPosition with the character's current position
	startPosition = position
	
	# If endPoint is set, use its position as the end position
	if endPoint:
		endPosition = endPoint.position
	else:
		# Otherwise, calculate endPosition by adding 500 units to the right of startPosition
		endPosition = startPosition + Vector2(500, 0)

# Function to switch the start and end positions to change direction
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

# Function to update the character's velocity based on the target direction
func updateVelocity():
	var moveDirection = (endPosition - position)
	# If the character is close enough to the end position, change direction
	if moveDirection.length() < limit:
		changeDirection()
	# Normalize the movement direction and scale by speed
	velocity = moveDirection.normalized() * speed

# Called every physics frame
func _physics_process(delta):
	# Set the animation to 'running'
	sprite_2d.animation = 'running'
	
	# Apply gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Update the character's velocity based on direction
	updateVelocity()
	
	# Move the character and handle collisions
	move_and_slide()
	handleCollision()
	
	# Flip the sprite based on the direction of movement
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# Function to handle collisions
func handleCollision():
	# Iterate through all slide collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		# You can add collision handling logic here

# Called when the character's hurtbox detects an area entering it
func _on_hurtbox_area_entered(area):
	# Ignore collisions with the character's own hitbox
	if area == $"Hitbox": return
	
	# Play a hit sound
	$Hit.play()
	
	# Change the character's color to red to indicate damage
	sprite_2d.self_modulate = Color("red")
	
	# Wait for 0.25 seconds
	await get_tree().create_timer(0.25).timeout
	
	# Remove the character from the scene
	queue_free()

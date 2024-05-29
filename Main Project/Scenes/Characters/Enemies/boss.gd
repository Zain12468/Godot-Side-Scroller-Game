# This script extends CharacterBody2D and manages character movement, animation, collision handling, and health.

extends CharacterBody2D

# Get the gravity setting from the project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Cache a reference to the AnimatedSprite2D node
@onready var sprite_2d = $AnimatedSprite2D

# Exported variables for movement speed and health, adjustable in the editor
@export var speed = 350
@export var health = 3

# Cache a reference to the player target
@onready var target = $"../Scene Objects/Player"

# Cache a reference to the win display label in the UI
@onready var winDisplay = $"../UI/Panel/Label"

# Physics process function, called every physics frame
func _physics_process(delta):
	# Set the animation to 'running'
	sprite_2d.animation = 'running'
	
	# Check if the target is null, if so, find the player in the group
	if target == null:
		get_tree().get_nodes_in_group("Player")[0]
	else:
		# Move towards the target's position on the x-axis only
		velocity = position.direction_to(target.position) * speed
		velocity.y = 0
	
	# Add gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Move the character and handle collisions
	move_and_slide()
	handleCollision()
	
	# Flip the sprite horizontally based on the movement direction
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# Function to handle collisions
func handleCollision():
	# Loop through all slide collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

# Function called when the hurtbox area is entered
func _on_hurtbox_area_entered(area):
	# Ignore if the entered area is the Hitbox
	if area == $"Hitbox":
		return
	
	# Play the hit sound
	$Hit.play()
	
	# Decrease health by 1
	health -= 1
	
	# Check if health is zero
	if health == 0:
		# Change the sprite color to red and display the win label
		sprite_2d.self_modulate = Color("red")
		await get_tree().create_timer(0.25).timeout
		winDisplay.self_modulate = Color(1, 1, 1, 1)
		# Free the character from the scene
		queue_free()
	else:
		# Flash the sprite red to indicate damage taken
		sprite_2d.self_modulate = Color("red")
		await get_tree().create_timer(0.25).timeout
		sprite_2d.self_modulate = Color(1, 1, 1, 1)

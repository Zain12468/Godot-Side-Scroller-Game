# In the final project, the animation names should be changed accordingly
# Tweak SPEED, JUMP_VELOCITY, and velocity.x as needed

extends CharacterBody2D

# Signal to emit when health changes
signal healthChanged

# Constants for movement speed and jump velocity
const SPEED = 500.0
const JUMP_VELOCITY = -950.0

# Cache a reference to the Sprite2D node
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Exported variables for health and knockback power
@export var maxHealth = 3
@onready var currentHealth: int = 3
@export var knockbackPower: int = 800

# Physics process function, called every physics frame
func _physics_process(delta):
	# Handle animations based on movement
	if (velocity.x > 1 or velocity.x < -1):
		sprite_2d.animation = 'Running'
	else:
		sprite_2d.animation = 'Idle'
	
	# Add gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = 'Jumping'

	# Handle jump input
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Jump.play()

	# Get the input direction and handle movement/deceleration
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 40)

	# Move the character and handle collisions
	move_and_slide()
	
	# Flip the sprite based on movement direction
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# Function to handle when the hurtbox area is entered
func _on_hurtbox_area_entered(area):
	if area.name == "Hitbox":
		# Reduce health and check if the player is dead
		currentHealth -= 1
		if currentHealth < 1:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level 1.tscn")
			MainMenu.died = true
		# Emit the healthChanged signal
		healthChanged.emit(currentHealth)
		# Apply knockback effect
		knockback(area.get_parent().velocity)

# Function to apply knockback when hit by an enemy
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

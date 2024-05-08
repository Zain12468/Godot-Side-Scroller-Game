
#In the final project, the animations name should be changed accordingly
#Tweak, Speed, Jump V, and velcoity.x as needed

extends CharacterBody2D

signal healthChanged

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var maxHealth = 3
@onready var currentHealth: int = 3

func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1 ):
		sprite_2d.animation = 'Running'
	else:
		sprite_2d.animation = 'Idle'
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = 'Jumping'

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 40)

	move_and_slide()
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft


func _on_hurtbox_area_entered(area):
	if area.name == "Hitbox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
			
		healthChanged.emit(currentHealth)

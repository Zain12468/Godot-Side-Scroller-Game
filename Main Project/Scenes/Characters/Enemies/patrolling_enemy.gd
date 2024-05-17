extends CharacterBody2D

#FLip if it touches a wall

var SPEED = 150.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true
var startPosition
var endPosition

@onready var sprite_2d = $AnimatedSprite2D
@export var limit = 0.5
@export var xOffset = 25
@export var raycastDistance = 37



func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(0, 3*16)

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized*SPEED

func _physics_process(delta):
	#Animations
	sprite_2d.animation = 'running'
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
		
	velocity.x = SPEED
	move_and_slide()
	handleCollision()
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()


func flip():
	#Flips the player
	facing_right = !facing_right
	scale.x = abs(scale.x) + -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1


func _on_hurtbox_area_entered(area):
	if area == $"Hitbox": return
	sprite_2d.self_modulate = Color("red")
	await get_tree().create_timer(0.25).timeout
	queue_free()
	
	


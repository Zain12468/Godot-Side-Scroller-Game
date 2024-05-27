extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var startPosition
var endPosition

@onready var sprite_2d = $AnimatedSprite2D
@export var speed = 300
@export var limit = 0.5


func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(500, 0)

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed


func _physics_process(delta):
	#Animations
	sprite_2d.animation = 'running'
	if not is_on_floor():
		velocity.y += gravity * delta
		
	updateVelocity()
	move_and_slide()
	handleCollision()
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()



func _on_hurtbox_area_entered(area):
	if area == $"Hitbox": return
	sprite_2d.self_modulate = Color("red")
	await get_tree().create_timer(0.25).timeout
	queue_free()
	
	


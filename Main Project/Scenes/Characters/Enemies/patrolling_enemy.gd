extends CharacterBody2D

@onready var sprite_2d = $AnimatedSprite2D
@export var group_name : String

var SPEED = 175.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true

func _physics_process(delta):
	#Animations
	sprite_2d.animation = 'running'
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = SPEED
	move_and_slide()
	handleCollision()
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
func _on_hurtbox_area_entered(area):
	if area == $"Hitbox": return
	sprite_2d.self_modulate = Color("red")
	await get_tree().create_timer(0.25).timeout
	queue_free()
	
	


extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var sprite_2d = $AnimatedSprite2D
@export var speed = 350
@export var health = 3

@onready var target = $"../Scene Objects/Player"

@onready var winDisplay = $"../UI/Panel/Label"

func _physics_process(delta):
	#Animations
	sprite_2d.animation = 'running'
	
	if target == null: get_tree().get_nodes_in_group("Player")[0]
	else:
		velocity = position.direction_to(target.position) * speed
		velocity.y = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
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
	$Hit.play()
	health -= 1
	if health == 0:
		sprite_2d.self_modulate = Color("red")
		await get_tree().create_timer(0.25).timeout
		winDisplay.self_modulate = Color(1, 1, 1, 1)		
		queue_free()
	else:
		sprite_2d.self_modulate = Color("red")
		await get_tree().create_timer(0.25).timeout
		sprite_2d.self_modulate = Color(1, 1, 1, 1)
		
		
	


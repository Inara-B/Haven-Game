extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -850.0


func _physics_process(delta: float) -> void:
	
	#animation
	
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction:
			velocity.x = direction * SPEED
			animated_sprite_2d.play("run")  # Changed to play("run") or "walk" depending on your preference
			animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		# Play jumping if in the air
		animated_sprite_2d.play("jumping")
	else:
		# Only play ground animations if we are actually on the floor
		if direction:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
		
	move_and_slide()

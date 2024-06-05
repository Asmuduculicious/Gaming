extends CharacterBody2D


@export var speed := 100.0
@export var jump_velocity = -200.0

var double_jump = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var weapon = 0

	


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		double_jump = true
			

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	elif Input.is_action_just_pressed("ui_accept") and double_jump:
		velocity.y = jump_velocity
		double_jump = false

	# Get the input direction and handle the movemednt/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = direction 
		$AnimatedSprite2D2.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	
	if Input.is_action_just_pressed("ui_swap"):
		weapon += 1
		if weapon == 3:
			weapon = 0
		if weapon == 0:
			$AnimatedSprite2D.play("spear_idle")
		if weapon == 1:
			$AnimatedSprite2D.play("bow_idle")
		if weapon == 2:
			$AnimatedSprite2D.play("gun_idle")
			
	if weapon == 0:
		if Input.is_action_just_pressed("ui_attack"):
			$AnimatedSprite2D2.play("spear_attack")
	if weapon == 1:
		if Input.is_action_just_pressed("ui_attack"):
				$AnimatedSprite2D2.play("bow_attack")
	if weapon == 2:
		if Input.is_action_just_pressed("ui_attack"):
			$AnimatedSprite2D2.play("gun_attack")	
		


	move_and_slide()

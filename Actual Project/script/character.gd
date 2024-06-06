extends CharacterBody2D

@export var speed := 100.0
@export var jump_velocity = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var double_jump = true

var weapon = 0
var weapon_idle = ["spear_idle", "bow_idle", "gun_idle"]
var weapon_attack = ["spear_attack", "bow_attack", "gun_attack"]

func _ready():
	$AnimatedSprite2D2.play("spear_idle")

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
		$AnimatedSprite2D2.play(weapon_idle[weapon])
	
	if Input.is_action_just_pressed("ui_attack"):
		$AnimatedSprite2D2.play(weapon_attack[weapon])
		
	if Input.is_action_pressed("ui_attack"):
		$AnimatedSprite2D2.play(weapon_attack[weapon])
		


	move_and_slide()

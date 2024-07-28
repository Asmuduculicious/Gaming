extends CharacterBody2D

@export var speed := 100.0
@export var jump_velocity = -200.0
@export var bullet_scene: PackedScene
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hp = 100
var locked = false

var double_jump = true
var can_shoot_bow = true
var can_shoot_gun = true
var weapon = 0
var weapon_idle = ["spear_idle", "bow_idle", "gun_idle"]
var weapon_attack = ["spear_attack", "bow_attack", "gun_attack"]

func _ready():
	hp = 100
	$AnimatedSprite2D2.play("spear_idle")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		double_jump = true

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	elif Input.is_action_just_pressed("ui_accept") and double_jump:
		velocity.y = jump_velocity
		double_jump = false
	
	move_and_slide()

	var direction = Input.get_axis("ui_left", "ui_right")
	if locked == false:
		if direction:
			velocity.x = direction * speed
			$AnimatedSprite2D.play("walk")
			if can_shoot_bow and can_shoot_gun:
				$AnimatedSprite2D.scale.x = direction 
				$AnimatedSprite2D2.scale.x = direction
				$Area2D2.scale.x = direction
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	
	if Input.is_action_just_pressed("ui_spear") and can_shoot_bow and can_shoot_gun:
		weapon = 0
		$AnimatedSprite2D2.play(weapon_idle[weapon])
	elif Input.is_action_just_pressed("ui_bow") and can_shoot_bow and can_shoot_gun:
		weapon = 1
		$AnimatedSprite2D2.play(weapon_idle[weapon])
	elif Input.is_action_just_pressed("ui_gun") and can_shoot_bow and can_shoot_gun:
		weapon = 2
		$AnimatedSprite2D2.play(weapon_idle[weapon])
	
	
	if Input.is_action_just_pressed("ui_attack"):
		if weapon == 0: 
			$AnimatedSprite2D2.play(weapon_attack[weapon])
			$AnimationPlayer.play("spear_attack")
		elif weapon == 1 and can_shoot_bow:
			$Timer.start()
			$AnimatedSprite2D2.play(weapon_attack[weapon])
			can_shoot_bow = false
		elif weapon == 2 and can_shoot_gun:
			$Timer3.start()
			$AnimatedSprite2D2.play(weapon_attack[weapon])
			can_shoot_gun = false
			
func _shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = $arrow_spawn.global_position
	bullet.position.y += 200
	bullet.direction = $AnimatedSprite2D.scale.x
	add_sibling(bullet)
	
func _on_timer_timeout():
	_shoot()
	$Timer2.start()

func _on_timer_2_timeout():
	can_shoot_bow = true
		
func _on_timer_3_timeout():
	_shoot()
	$Timer4.start()

func _on_timer_4_timeout():
	can_shoot_gun= true


func _enemy_hit_body(area):
	if area.has_meta("enemyweapon"):
		print(hp)
		hp -= 25
		if hp == 0:
			$Area2D2/spear.disabled = true
			$Area2D2.hide()
			$Area2D2.set_visible(false)
			$AnimatedSprite2D.hide()
			$AnimatedSprite2D2.hide()
			$CollisionShape2D.disabled = true
			$Area2D3.hide()
			$Area2D3/CollisionShape2D2.disabled = true
			$Timer6.start()
			global.dead = true
		else:
			locked = true
			print(area.scale.x)
			velocity.x = 600 * area.scale.x
			velocity.y = -300
			$Timer5.start()
			

func _on_timer_5_timeout():
	locked = false


func _on_timer_6_timeout():
	queue_free()

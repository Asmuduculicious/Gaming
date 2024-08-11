extends CharacterBody2D

@export var speed := 100.0
@export var jump_velocity = -200.0
@export var bullet_scene: PackedScene
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var locked = false
var double_jump = true
var can_shoot_bow = true
var can_shoot_gun = true
var weapon = 0
var weapon_idle = ["spear_idle", "bow_idle", "gun_idle"]
var weapon_attack = ["spear_attack", "bow_attack", "gun_attack"]
@onready var global = get_node("/root/GlobalVar")

func _ready():
	$Label.visible = false
	global.hp = 100
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
			if global.arrow > 0:
				global.bullet -= 1
				$Timer.start()
				$AnimatedSprite2D2.play(weapon_attack[weapon])
				can_shoot_bow = false
			else:
				$Timer7.start()
				$Label.visible = true
		elif weapon == 2 and can_shoot_gun:
			if global.bullet > 0:
				global.bullet -= 1
				$Timer3.start()
				$AnimatedSprite2D2.play(weapon_attack[weapon])
				can_shoot_gun = false
			else:
				$Label.visible = true
				$Timer7.start()
			

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


func _on_timer_5_timeout():
	locked = false


func _on_timer_6_timeout():
	queue_free()


func enemy_hit_body(area):
	if area.has_meta("enemy_weapon"):
		global.hp -= 25
		if global.hp == 0:
			get_tree().change_scene_to_file("res://scene/Dead.tscn")
		else:
			locked = true
			print(area.scale.x)
			velocity.x = 600 * area.scale.x
			velocity.y = -300
			$Timer5.start()
	if area.has_meta("Exit"):
		get_tree().change_scene_to_file("res://scene/LevelSelection.tscn")
		if global.current_level == "Tutorial":
			global.tutorial = true
		if global.current_level == "Level_1":
			global.level_1 = true
		if global.current_level == "Level_2":
			global.level_2 = true
		if global.current_level == "Level_3":
			global.level_3 = true
		if global.current_level == "Level_4":
			global.level_4 = true
		if global.current_level == "Level_5":
			global.level_5 = true
	if area.has_meta("Spike") and area.in_pit:
		global.hp -= 50
		if global.hp == 0:
			get_tree().change_scene_to_file("res://scene/Dead.tscn")
		else:
			velocity.y = area.spikiness


func _on_timer_7_timeout():
	$Label.visible = false

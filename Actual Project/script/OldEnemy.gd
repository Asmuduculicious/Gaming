extends CharacterBody2D

var speed = 20
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rotation_speed = 0.01
var on_top = false
var flipped = false
var attacked = false
@onready var global = get_node("/root/GlobalVar")

func _process(delta):
	move_and_slide()
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if $Enemysword/RayCast2D.is_colliding():
		if flipped == false:
			velocity.x = direction * speed
	else:
		if on_top == false:
			_flip()
	
	if $Enemysword/RayCast2D2.is_colliding():
		if $Enemysword/RayCast2D2.get_collider().has_meta("enemy") or $Enemysword/RayCast2D2.get_collider().has_meta("wall"):
			if flipped == false:
				flipped = true
				$Timer.start()
			
	if $Enemysword/RayCast2D3.is_colliding():		
		if $Enemysword/RayCast2D3.get_collider().has_meta("player"):
			if attacked == false:
				attacked = true
				$Timer2.start()
				_attack()

func _on_area_2d_3_body_entered(body):
	if body.has_meta("player"):
		on_top = true
	elif body.has_meta("enemy"):
		on_top = true
	else:
		on_top = false

func _attack():
	$AnimationPlayer.play("attack")
	
func _flip():
	velocity.x = 0
	direction = direction * -1
	$Enemysword.scale.x = direction
	$Area2D.scale.x = direction
	if $Area2D2.scale.x < 0 and direction > 0:
		$Area2D2.scale.x = 1.4
	else:
		$Area2D2.scale.x = $Area2D2.scale.x * direction
	

func _hit(area):
	if area.has_meta("spear"):
		_die()
		
func _die():
	$Enemysword.hide()
	$CollisionShape2D.disabled = true
	$Area2D.set_visible(false)
	$Area2D/CollisionShape2D.disabled = true
	$Area2D3.hide()
	$Area2D3/CollisionShape2D.disabled = true
	$Area2D2.hide()
	$Area2D2/CollisionShape2D.disabled = true
	$Timer3.start()
	global.kills += 1
	
func _on_timer_timeout():
	flipped = false
	
	_flip()

func _on_timer_2_timeout():
	attacked = false



func _on_timer_3_timeout():
	queue_free()

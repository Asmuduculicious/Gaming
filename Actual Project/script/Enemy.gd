extends CharacterBody2D

var speed = 20
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	if $Sprite2D/RayCast2D.is_colliding():
			velocity.x = direction * speed
	else:
		_flip()

func _attack():
	pass

func _see(body):
	if not body.has_meta("player"):
		_flip()
	else:
		_attack()
		
func _unsee(body):
	if not body.has_meta("player"):
		pass
	else:
		pass
		
func _flip():
	velocity.x = 0
	direction = direction * -1
	$Sprite2D.scale.x = direction
	velocity.x = direction * speed


#func _hit(area):
	#print("111")
	#if area.has_meta("spear"):
		#queue_free()

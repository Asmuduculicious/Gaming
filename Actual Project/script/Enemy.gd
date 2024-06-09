extends CharacterBody2D

var speed = 50

var direction = 1


func _process(delta):
	move_and_slide()
	if $RayCast2D.is_colliding():
			velocity.x = direction * speed
	if not $RayCast2D.is_colliding():
		print("cringe")
		velocity.x = 0
		direction = direction * -1
		$RayCast2D.scale.x = direction
		$Sprite2D.scale.x = direction
		velocity.x = direction*speed
		print("oop")
	
	#if $RayCast2D.is_colliding(CharacterBody2D):
		_attack()

func _attack():
	pass

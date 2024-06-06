extends Area2D

var speed = 500
var direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x((speed * direction) * delta)

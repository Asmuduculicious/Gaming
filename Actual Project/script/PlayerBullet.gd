extends Area2D

@onready var character = get_node("/root/Node2D/CharacterBody2D/")
var speed = 300
var direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x((speed * direction) * delta)

func _ready():
	if character.weapon == 1:
		speed = 300
		$Arrow.texture = preload("res://assets/Arrow.png")
	elif character.weapon == 2:
		$Arrow.texture = preload("res://assets/bullet.png")
		speed = 500 

func _on_body_entered(body):
	if !body.has_meta("player"):
		queue_free()

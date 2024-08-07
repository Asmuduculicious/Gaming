extends Area2D

@onready var character = get_node("/root/Node2D/CharacterBody2D/")
var speed = 150
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x((speed * direction) * delta)

func _ready():
	$Arrow.texture = preload("res://assets/bullet.png")



func _on_area_entered(area):
	if area.has_meta("enemy") or area.has_meta("player") or area.has_meta("wall"):
		queue_free()

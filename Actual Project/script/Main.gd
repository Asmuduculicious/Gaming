extends Node2D
var enemy = preload("res://scene/enemy.tscn")
var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	global.current_level = "tutorial"
	for i in range(0):
		var new_enemy = enemy.instantiate()
		new_enemy.name = new_enemy.name + str(i)
		add_child(new_enemy)
		x = randi_range(-600,600)
		y = randi_range(-2000,0)
		new_enemy.position = Vector2(x, y)
		new_enemy.speed = randi_range(30,100)

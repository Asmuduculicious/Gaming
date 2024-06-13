extends Node2D
var enemy = preload("res://scene/enemy.tscn")
var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var new_enemy = enemy.instantiate()
		new_enemy.name = new_enemy.name + str(i)
		add_child(new_enemy)
		x = randi_range(-200,200)
		y = randi_range(-1000,0)
		new_enemy.position = Vector2(x, y)
		new_enemy.gravity = randi_range(100,980)
		new_enemy.speed = randi_range(10,100)
	$Timer.start()
	
func _on_timer_timeout():
	if global.dead == false:
		var new_enemy = enemy.instantiate()
		add_child(new_enemy)
		x = randi_range(-200,200)
		y = randi_range(-200,0)
		new_enemy.position.x += $CharacterBody2D.get_position().x + x
		new_enemy.position.y += $CharacterBody2D.get_position().y + y
		new_enemy.gravity = randi_range(100,980)
		new_enemy.speed = randi_range(10,100)
	
func _process(delta):
	pass

func _on_button_pressed():
	global.dead = false
	get_tree().reload_current_scene()


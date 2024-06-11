extends Node2D
var enemy = preload("res://scene/enemy.tscn")
var x = 0
var y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(300):
		var new_enemy = enemy.instantiate()
		new_enemy.name = new_enemy.name + str(i)
		add_child(new_enemy)
		x = randi_range(-500,500)
		y = randi_range(-500,500)
		new_enemy.position = Vector2(x, y)
		new_enemy.gravity = randi_range(-980,980)
		print(new_enemy.gravity)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	

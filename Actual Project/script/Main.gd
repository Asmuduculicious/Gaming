extends Node2D

@onready var global = get_node("/root/GlobalVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	global.current_level = "Tutorial"
	global.arrow += 10

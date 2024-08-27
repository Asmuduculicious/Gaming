extends Node2D

@onready var global = get_node("/root/GlobalVar")
var arrow_pickup_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		queue_free()
		arrow_pickup_number = randi_range(1,3)
		global.arrow += arrow_pickup_number

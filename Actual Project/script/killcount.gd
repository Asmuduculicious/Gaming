extends CanvasLayer

@onready var global = get_node("/root/GlobalVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = ("Kill count : " + str(global.kills)) + "\n" + ("Arrow count : " + str(global.arrow)) + "\n" + ("Bullet count : " + str(global.bullet)) + "\n" + ("HP : " + str(global.hp))

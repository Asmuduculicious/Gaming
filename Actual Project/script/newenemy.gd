extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
	pass

func _on_area_area_entered(area):
	if area.has_meta("player_weapon"):
		queue_free()

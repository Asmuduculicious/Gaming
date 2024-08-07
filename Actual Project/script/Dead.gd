extends Node2D




func _on_button_pressed():
	print("no")
	if global.current_level == "tutorial":
		get_tree().change_scene_to_file("res://scene/Tutorial.tscn")


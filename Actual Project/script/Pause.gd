extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.visible = false
	$Button4.visible = true

func _process(delta):
	pass


func _on_button_4_pressed():
	$Area2D.visible = true
	$Button4.visible = false
	get_tree().paused = true

func _on_button_pressed():
	$Area2D.visible = false
	$Button4.visible = true
	get_tree().paused = false


func _on_button_2_pressed():
	pass # Replace with function body.


func _on_button_3_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/LevelSelection.tscn")


extends Control


var main = preload("res://Scenes/Main.tscn")


func _ready():
	
	pass



func _on_Back_pressed():
	get_tree().change_scene_to(main)


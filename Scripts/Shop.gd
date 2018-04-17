extends Control


var main = preload("res://Scenes/Main.tscn")
var inventory = preload("res://Scenes/Inventory.tscn")


func _ready():
	
	pass



func _on_Back_pressed():
	get_tree().change_scene_to(main)



func _on_Inventory_button_down():
	get_tree().change_scene_to(inventory)
	pass # replace with function body

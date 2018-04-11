extends Area2D



func _ready():
	pass




func _on_Sword_area_entered(area):
	area.death_animation(global_rotation, get_parent().get_parent().attack_left)
	
	pass

extends Area2D

export (int) var energy_cost

func _ready():
	pass




func _on_Sword_area_entered(area):
	area.death_animation(global_rotation, get_parent().get_parent().attack_left)
	get_parent().get_parent().add_energy(energy_cost)
	pass

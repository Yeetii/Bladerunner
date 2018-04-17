extends Area2D

export (int) var energy_cost
export (float) var attack_speed

func _ready():
	connect("area_entered", self, "sword_area_entered")

func sword_area_entered(area):
	area.death_animation(global_rotation, get_parent().get_parent().attack_left)
	get_parent().get_parent().add_energy(energy_cost)
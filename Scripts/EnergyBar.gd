extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var player

var energy = 3
var max_energy = 3
var new_energy = 3
var lerp_energy

func _ready():
	energy = get_node(player).energy
	new_energy = get_node(player).energy
	max_energy = get_node(player).max_energy
	get_node(player).connect("energy_changed", self, "update_energy_bar")


func _process(delta):
	energy = lerp(energy, new_energy, 10 * delta)
	value = energy / max_energy
	
	
	

func update_energy_bar(updated_energy):
	new_energy = updated_energy

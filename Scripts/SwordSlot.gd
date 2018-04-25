extends TextureButton

var data = {}

onready var inventory_node = get_tree().root.get_node("Inventory")

var equiped_color = Color(0, 0.47, 0.1, 1)
var un_equiped_color = Color(1, 1, 1, 1)

func _ready():
	Global.connect("update_equiped_sword", self, "equiped_sword_changed")
	pass

func _on_SwordSlot_button_down():
	if data.id != Global.data.equiped_sword:
		Global.set_equiped_sword(data.id)
		self_modulate = equiped_color
		
		inventory_node.update_player_visuals()
		



func set_data(sword_data):
	data = sword_data
	update()

func update():
	print("sword data: ", data)
	$CenterContainer/TextureRect.texture = data.texture
	
	if data.id == Global.data.equiped_sword:
		self_modulate = equiped_color


func equiped_sword_changed(sword):
	if data.id != sword:
		self_modulate = un_equiped_color
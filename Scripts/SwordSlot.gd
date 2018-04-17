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
		
		var player_sword_node = inventory_node.get_node("PlayerVisuals/PlayerSword")
		# remove old
		player_sword_node.get_children()[0].queue_free()
		# add new
		var new_sword = data.scene.instance()
		player_sword_node.add_child(new_sword)



func set_data(sword_data):
	data = sword_data
	update()

func update():
	print("sword data: ", data)
	$CenterContainer/TextureRect.texture = data.texture
	
	if data.id == Global.data.equiped_sword:
		self_modulate = equiped_color
	

func _on_SwordSlot_pressed():
	print("press ",get_tree().root.name)
	pass # replace with function body

func equiped_sword_changed(sword):
	if data.id != sword:
		self_modulate = un_equiped_color
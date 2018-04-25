extends Control

var sword_slot = preload("res://Scenes/SwordSlot.tscn")
var main = preload("res://Scenes/Main.tscn")

func _ready():
	var unlocked_swords = Global.data.unlocked_weapons.swords
	for sword in unlocked_swords:
		var new_sword_slot = sword_slot.instance()
		$ScrollContainer/Swords.add_child(new_sword_slot)
		new_sword_slot.set_data(Global.get_sword(sword))
		pass
	
	update_player_visuals()

func update_player_visuals():
	var player_sword_node = get_node("PlayerVisuals/PlayerSword")
	# remove old
	if (player_sword_node.get_children().size() > 0):
		player_sword_node.get_children()[0].queue_free()
	# add new
	var new_sword = Global.get_sword(Global.data.equiped_sword).scene.instance()
	player_sword_node.add_child(new_sword)


func _on_Home_button_down():
	get_tree().change_scene_to(main)
	pass # replace with function body

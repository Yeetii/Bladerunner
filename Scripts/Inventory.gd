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



func _on_Home_button_down():
	get_tree().change_scene_to(main)
	pass # replace with function body

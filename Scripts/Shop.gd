extends Control


var main = preload("res://Scenes/Main.tscn")
var inventory = preload("res://Scenes/Inventory.tscn")
var chest_item = preload("res://Scenes/ItemFromChest.tscn")

var item_spawn_pos
var item_target_pos

func _ready():
	Global.emit_signal("update_gold", Global.data.gold)
	
	item_spawn_pos = $Chest/Sprite.global_position
	item_target_pos = $Chest/Sprite.global_position + Vector2(0, -200)
	pass



func _on_Back_pressed():
	get_tree().change_scene_to(main)



func _on_Inventory_button_down():
	get_tree().change_scene_to(inventory)
	pass # replace with function body


func _on_Chest_pressed():
	if $Chest/Sprite.frame < 4:
		$Chest/Sprite.frame += 1
	if $Chest/Sprite.frame == 4:
		$Chest/AnimationPlayer.play("ChestAnimation")
		
		spawn_item()

func _on_AnimationPlayer_animation_finished(anim_name):
	$Chest/Sprite.frame = 0

func spawn_item():
	var new_item = Global.open_chest()
	if new_item != null:
		var item_visuals = chest_item.instance()
		add_child(item_visuals)
		item_visuals.global_position = item_spawn_pos
		item_visuals.spawn(new_item.texture, item_target_pos)
		
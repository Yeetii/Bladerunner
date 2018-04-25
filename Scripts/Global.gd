extends Node

const SAVE_PATH = "user://save.json"

signal update_gold(gold)
signal update_sword(sword)

signal update_equiped_sword(sword)

enum RARITY {
	common,
	uncommon,
	rare,
	epic,
	legendary
}

var is_playing = false
var paused = false



#weapons
var weapons = {
	swords = {
		sword_wood = {
			id = "sword_wood",
			rarity = RARITY.common,
			scene = preload("res://Scenes/SwordWood.tscn"),
			texture = preload("res://Sprites/Weapons/sword_wood.png"),
		},
		sword_dagger = {
			id = "sword_dagger",
			rarity = RARITY.uncommon,
			scene = preload("res://Scenes/SwordDagger.tscn"),
			texture = preload("res://Sprites/Weapons/sword_dagger.png"),
		},
		sword_winged_mace = {
			id = "sword_winged_mace",
			rarity = RARITY.uncommon,
			scene = preload("res://Scenes/SwordWingedMace.tscn"),
			texture = preload("res://Sprites/Weapons/sword_wingedmace.png"),
		}
	}
}

# data som ska sparas.
var data = {
	high_score = 0,
	gold = 0,
	
	equiped_sword = "sword_wood",
	unlocked_weapons = {
		swords = [
			"sword_wood",
		]
	}
}



func _ready():
	#load_game()
	pass

func get_sword(name):
	return weapons.swords[name]

func unlock_sword(name):
	data.unlocked_weapons.swords.append(name)


func set_equiped_sword(sword):
	data.equiped_sword = sword
	emit_signal("update_equiped_sword", sword)

func remove_save():
	var dir = Directory.new()
	dir.remove(SAVE_PATH)


func open_chest():
	# Randomize
	var unlockable_swords = []
	
	for sword in weapons.swords.values():
		var add_item = true
		for unlocked_sword in data.unlocked_weapons.swords:
			if sword.id == unlocked_sword:
				add_item = false
		if add_item:
			unlockable_swords.append(sword)
	
	print("Swords that you can get: ", unlockable_swords)
	
	
	if unlockable_swords.size() > 0:
		var new_sword = unlockable_swords[rand_range(0, unlockable_swords.size())]
		unlock_sword(new_sword.id)
		return new_sword
		
	
	return null

func update_high_score(new_score):
	if new_score > data.high_score:
		data.high_score = new_score


func add_gold(value):
	data.gold += value
	emit_signal("update_gold", data.gold)


func update_text():
	emit_signal("update_gold", data.gold)



func save_game():
	var save_file = File.new()
	
	var save_data = data
	
	
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(save_data))
	print ("Saved")
	save_file.close()

func load_game():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_PATH):
		print ("No save")
		return
	
	var currentline = {}
	save_file.open(SAVE_PATH, File.READ)
	currentline = parse_json(save_file.get_line())
	print("current line " , currentline)
	print("currentline.highscore", currentline.equiped_sword)
	
	# todo
	# gå igenom ALLA keys i dictonaryn HUUUR??? while there is dictionary?
	# ändra saker som redan fanns innan
	
	
	for key in currentline:
		if currentline.has("unlocked_weapons"):
			if key == "unlocked_weapons":
				for weapon in currentline[key]:
					for sword in range(0, currentline[key][weapon].size()):
						data[key][weapon][sword] = currentline[key][weapon][sword]
				continue
		data[key] = currentline[key]
	
	
	#data = currentline
	print("loaded successfully")
	print("data", data)
	
	save_file.close()
	
	update_text()
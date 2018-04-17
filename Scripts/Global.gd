extends Node

const SAVE_PATH = "user://save.json"

signal update_gold(gold)
signal update_sword(sword)

enum RARITY {
	common,
	uncommon,
	rare,
	epic,
	legendary
}

var is_playing = false
var paused = false

var sword_wood = preload("res://Scenes/SwordWood.tscn")


var data = {
	high_score = 0,
	gold = 0,
	
	weapons = {
		swords = {
			sword_wood = {
				rarity = RARITY.common,
				scene = preload("res://Scenes/SwordWood.tscn"),
				texture = preload("res://Sprites/Weapons/sword_wood.png"),
			},
			sword_dagger = {
				rarity = RARITY.uncommon,
				scene = preload("res://Scenes/SwordDagger.tscn"),
				texture = preload("res://Sprites/Weapons/sword_dagger.png"),
			}
		}
	},
	unlocked_weapons = {
		swords = [
			"sword_wood",
			"sword_dagger",
		]
	}
}



func _ready():
	print("unlocked weaposn", data.unlocked_weapons.swords)
	print("vasasd " ,data.weapons.swords.sword_wood)
	data.equiped_sword = data.weapons.swords.sword_wood
	print("equiped sword ready ", data.equiped_sword)
	load_game()
	
	print("--------------------------------Test 1------------------------------")
	var test = {
		test1 = {
			sak = "hej",
			sak2 = "då",
		},
		test2 = "asd"
	}
	print("test: ", test)
	print("test.values: ", test.values())
	for key in test:
		print ("key: ", key)

func get_sword(name):
	return data.weapons.swords[name]



func remove_save():
	var dir = Directory.new()
	dir.remove(SAVE_PATH)



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
	
	
	# fix tihis
	"""for key in data:
		print("load key: ", key)
		if currentline.has(key):
			
			data[key] = currentline[key]
	
	for key in currentline:
		print("current line ",key )
	"""
	data = currentline
	print("loaded successfully")
	print("data after load scene: ", data.equiped_sword.scene)
	
	save_file.close()
	
	update_text()
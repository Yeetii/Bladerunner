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

var sword_wood = preload("res://Scenes/SwordWood.tscn")

# preload i dictionary bug???


var data = {
	high_score = 0,
	gold = 0,
	
	equiped_sword = "sword_wood",
	# Behöver inte sparas bara unlocked weapons
	weapons = {
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
	#load_game()
	pass

func get_sword(name):
	return data.weapons.swords[name]

func set_equiped_sword(sword):
	data.equiped_sword = sword
	emit_signal("update_equiped_sword", sword)

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
	
	# todo
	# gå igenom alla keys i dictonaryn
	# ändra saker som redan fanns innan
	# load är help cp just nu och crashar
	
	
	for key in currentline:
		data[key] = currentline[key]
	
	#data = currentline
	print("loaded successfully")
	print("data", data)
	
	save_file.close()
	
	update_text()
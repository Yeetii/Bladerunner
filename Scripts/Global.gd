extends Node

const SAVE_PATH = "user://save.json"

signal update_gold(gold)

var is_playing = false
var paused = false

var data = {
	high_score = 0,
	gold = 0,
}

func _ready():
	load_game()

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
	
	var currentline = {}
	save_file.open(SAVE_PATH, File.READ)
	currentline = parse_json(save_file.get_line())
	print("current line " , currentline)
	
	
	for key in data:
		if currentline.has(key):
			data[key] = currentline[key]
	
	print("loaded successfully")
	save_file.close()
	
	update_text()
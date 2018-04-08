extends Node

const SAVE_PATH = "user://save.json"

var is_playing = false
var paused = false

var high_score = 0

func _ready():
	print("ready")
	load_game()

func update_high_score(new_score):
	if new_score > high_score:
		high_score = new_score

func save_game():
	var save_file = File.new()
	
	var data = {
		high_score = high_score
	}
	
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(data))
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
	high_score = currentline.high_score
	save_file.close()
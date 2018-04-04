extends Node

var background = preload("res://Scenes/background.tscn")
var old_b
var new_b
var last_pos = 0

func _ready():
	old_b = background.instance()
	add_child(old_b)
	
	
	new_b = background.instance()
	add_child(new_b)
	new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
	pass

func _process(delta):
	#print(-int($Player.position.y) % 1000)
	if ($Player.position.y < (last_pos - 854)):
		last_pos = last_pos - 854

		var temp = old_b
		old_b = new_b
		new_b = temp
		new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
		print(old_b.get_texture().get_size().y)
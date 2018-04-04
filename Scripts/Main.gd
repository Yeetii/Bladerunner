extends Node

var enemy = preload("res://Scenes/Enemy.tscn")

var spawn_xpos_random = 100
var spawn_yoffset = Vector2(0, -1000)

var time_alive = 0
var spawn_timer = 0
var base_time_between_spawn = 2
var time_between_spawn = 2

var time_randomness = 2

var background = preload("res://Scenes/Background.tscn")
var old_b
var new_b
var last_pos = 0

func _ready():
	#Init background
	old_b = background.instance()
	add_child(old_b)
	new_b = background.instance()
	add_child(new_b)
	new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
	pass

func _process(delta):
	spawn_timer += delta
	
	if spawn_timer >= time_between_spawn:
		spawn_enemy()
		
	#Move background forwards
	if ($Player.position.y + 200 < (last_pos - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y)):
		last_pos = last_pos - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
		var temp = old_b
		old_b = new_b
		new_b = temp
		new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y

func spawn_enemy():
	print(randf(-spawn_xpos_random, spawn_xpos_random))
	var new_enemy = enemy.instance()
	add_child(new_enemy)
	new_enemy.position = $Player.position + spawn_yoffset + Vector2(rand_range(-spawn_xpos_random, spawn_xpos_random), 0)
	# reset timer
	time_between_spawn = base_time_between_spawn *  exp(-$Player.time_alive/25) + rand_range(0, time_randomness)
	print("spawn time " + str(time_between_spawn))
	spawn_timer = 0
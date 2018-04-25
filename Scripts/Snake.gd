extends "res://Scripts/Enemy.gd"


var body = preload("res://Scenes/SnakeBody.tscn")

var time = 0

var direction = 1

export (int) var body_size = 20
export (int) var body_offset = 10

var spawn_x

var bodies = []

export (int) var side_movement_width = 50

func _ready():
	spawn_x = global_position.x
	side_movement_width += rand_range(-30, 30)
	
	
	#bodies = bodies.invert()

func spawn(player_pos):
	position = player_pos + spawn_offset + Vector2(rand_range(-spawn_xpos_random, spawn_xpos_random), 0)
	spawn_x = global_position.x
	
	for i in body_size:
		var new_body = body.instance()
		get_parent().call_deferred("add_child",new_body)
		new_body.global_position = global_position + Vector2(0, -( body_offset + body_offset*i))
		new_body.z_index = -i
		bodies.append(new_body)
	pass


func move(delta):
	
	
	time += delta * speed / 50
	position.y += speed * delta
	
	
	
	#var body_number = 1
	#var value = 1
	#var side_movement = 0
	
	var offset = 0.4
	var body_number = 0
	global_position.x = spawn_x + side_movement_width * sin(time)
	
	if !dead:
		for body in bodies:
			body_number += 1
			body.global_position.x = spawn_x + side_movement_width * sin(-body_number * offset + time)
			body.position.y += speed * delta

func die():
	print("die finciuk")
	var body_number = 0
	for body in bodies:
		body_number += 1
		body.fade_out_timer = 0.06 * body_number



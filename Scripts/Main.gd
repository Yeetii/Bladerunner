extends Node

var paused = false

var enemy = preload("res://Scenes/Enemy.tscn")



var spawn_xpos_random = 100
var spawn_yoffset = Vector2(0, -1000)

var time_alive = 0
var spawn_timer = 2
var base_time_between_spawn = 2
var time_between_spawn = 2

var time_randomness = 0.1

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
	

func _process(delta):
	#Update score
	if Global.is_playing:
		$UI/Score.set_text(str(get_score()) + " m")
	
		# spawn enemy timer
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
	time_between_spawn = base_time_between_spawn *  exp(-$Player.time_alive/50) + rand_range(0, time_randomness)
	spawn_timer = 0
	
func get_score():
	return int((-$Player.position.y + $Player.start_pos) / 200)
	
	
	

func _on_Play_pressed():
	Global.is_playing = true
	$UI/Play.hide()
	pass # replace with function body


func _on_Pause_pressed():
	paused = !paused
	if paused:
		$UI/Pause/AnimationPlayer.play("Pause_Animation")
	else:
		$UI/Pause/AnimationPlayer.play_backwards("Pause_Animation")
	get_tree().paused = paused

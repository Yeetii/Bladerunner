extends Node

var paused = false

var transition = preload("res://Scenes/Transition.tscn")

var shop = preload("res://Scenes/Shop.tscn")

var enemies = {}

# Enemies
export (int) var gobin_spawn_chance
export (PackedScene) var goblin

export (int) var goblin_adult_spawn_chance
export (PackedScene) var goblin_adult

export (int) var snake_spawn_chance
export (PackedScene) var snake


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
	Global.update_text()
	
	init_enemies()
	
	
	#Init background
	old_b = background.instance()
	add_child(old_b)
	new_b = background.instance()
	add_child(new_b)
	new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
	
	# Gör att randomen är random och inte samma varje gång
	randomize()

func _process(delta):
	if Global.is_playing:
		#Update score
		$UI/Score.set_text(str(get_score()) + " m")
	
		# spawn enemy timer
		spawn_timer += delta
		if spawn_timer >= time_between_spawn:
			spawn_enemy()
	
	#Move background forwards
	if has_node("Player"):
		if ($Player.position.y + 150 < (last_pos - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y)):
			last_pos = last_pos - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y
			var temp = old_b
			old_b = new_b
			new_b = temp
			new_b.position.y = old_b.position.y - old_b.get_texture().get_size().y * old_b.get_transform().get_scale().y

func spawn_enemy():
	var enemy = get_random_enemy()
	print("enemy ",enemy)
	var new_enemy = enemy.instance()
	add_child(new_enemy)
	new_enemy.spawn($Player.position)
	# reset timer
	time_between_spawn = base_time_between_spawn *  exp(-$Player.time_alive/50) + rand_range(0, time_randomness)
	spawn_timer = 0
	
func get_score():
	return int((-$Player.position.y + $Player.start_pos) / 200)

func get_random_enemy():
	var enemies_pool = []
	for i in enemies:
		for e in enemies[i].spawn_chance:
			enemies_pool.append(enemies[i])
	
	return enemies_pool[int(rand_range(0, enemies_pool.size()))].scene


func init_enemies():
	enemies = {
		goblin = {
			'spawn_chance': gobin_spawn_chance,
			'scene': goblin,
		},
		goblin_adult = {
			'spawn_chance': goblin_adult_spawn_chance,
			'scene': goblin_adult,
		},
		snake = {
			'spawn_chance': snake_spawn_chance,
			'scene': snake,
		}
	}





func _on_Play_pressed():
	Global.is_playing = true
	$UI/NotPlaying.hide()


func _on_Pause_pressed():
	Global.paused = !Global.paused
	if Global.paused:
		$UI/Pause/AnimationPlayer.play("Pause_Animation")
	else:
		$UI/Pause/AnimationPlayer.play_backwards("Pause_Animation")
	get_tree().paused = Global.paused

func restart():
	Global.update_high_score(get_score())
	Global.save_game()
	var new_transition = transition.instance()
	$UI.add_child(new_transition)
	new_transition.play("in")


func _on_Shop_pressed():
	get_tree().change_scene_to(shop)
	pass # replace with function body

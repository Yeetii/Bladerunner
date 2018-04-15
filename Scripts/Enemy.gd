extends Area2D


export (int) var base_speed = 150
export (int) var speed_randomness = 140
var speed

export (Vector2) var spawn_offset = Vector2(0, -1000)
export (int) var spawn_xpos_random = 100


func _ready():
	speed = base_speed + rand_range(-speed_randomness, speed_randomness)
	connect("body_entered", self, "on_body_entered")
	$Tween.connect("tween_completed", self, "on_tween_completed")
	

func _process(delta):
	move(delta)

func move(delta):
	position.y += speed * delta
	pass

func spawn(player_pos):
	position = player_pos + spawn_offset + Vector2(rand_range(-spawn_xpos_random, spawn_xpos_random), 0)
	pass


func _on_Enemy_body_entered(body):
	pass

func on_body_entered(body):
	body.die()

func death_animation(sword_rotation, attack_left):
	
	$CollisionShape2D.disabled = true
	
	var offset = Vector2(0, -100)
	var xRandom = rand_range(-100, 100)
	var max_length = 300
	
	var attack_direction
	if attack_left:
		attack_direction = -1
	else:
		attack_direction = 1

	if attack_direction < 0.1:
		attack_direction = -1
	var tween_pos = max_length * Vector2(attack_direction * sin(sword_rotation),attack_direction * -cos(sword_rotation)).normalized()
	
	$Tween.interpolate_property(self, "position", position, position + tween_pos, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "rotation", rotation, rotation + rand_range(-5*PI, 5*PI), 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 1, Tween.TRANS_EXPO, Tween.EASE_IN)
	
	$Tween.start()


func on_tween_completed(object, key):
	queue_free()

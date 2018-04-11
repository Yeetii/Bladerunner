extends Area2D

var base_speed = 150
var speed_randomness = 140
var speed

func _ready():
	speed = base_speed + rand_range(-speed_randomness, speed_randomness)
	pass

func _process(delta):
	position.y += speed * delta


func _on_Enemy_body_entered(body):
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
	print("diorection rad " + str((sword_rotation)))
	print("sowrd rot sin " + str(sin(sword_rotation*2)) +  "sowrd rot cos " + str(cos(sword_rotation*2)))
	#var tween_pos = Vector2(attack_direction * sin(sword_rotation) * max_length, -(1-sin(sword_rotation)) * max_length)
	if attack_direction < 0.1:
		attack_direction = -1
	var tween_pos = max_length * Vector2(attack_direction * sin(sword_rotation),attack_direction * -cos(sword_rotation)).normalized()
	
	$Tween.interpolate_property(self, "position", position, position + tween_pos, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "rotation", rotation, rotation + rand_range(-5*PI, 5*PI), 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 1, Tween.TRANS_EXPO, Tween.EASE_IN)
	
	$Tween.start()
	pass

func _on_Tween_tween_completed(object, key):
	queue_free()
	pass # replace with function body

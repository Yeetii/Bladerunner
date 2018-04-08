extends Area2D

var base_speed = 150
var speed_randomness = 140
var speed

func _ready():
	speed = base_speed + rand_range(-speed_randomness, speed_randomness)
	pass

func _process(delta):
	position.y += speed * delta

func _on_Enemy_area_entered(area):
	print("asd")
	if area.get_parent().get_name() == "Sword":
		queue_free()

func _on_Enemy_body_entered(body):
	print("test")
	body.die()

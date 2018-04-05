extends KinematicBody2D


var base_speed = Vector2(0, -3)
var speed = Vector2(0, -3)

var start_pos

var kills = 0


var attack_left = true
var can_attack = true
var attack_speed = .1

var time_alive = 0

export var max_speed = 10


func _ready():
	
	pass

func _process(delta):
	move_and_collide(speed)
	
	if Global.is_playing:
		time_alive += delta
		update_speed()


func _on_Tween_tween_completed(object, key):
	print("Done")
	can_attack = true


func attack():
	$Tween.interpolate_property($Sword, "rotation_degrees",
		  $Sword.rotation_degrees, -180 * int(attack_left),
		  attack_speed,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	$Tween.start()
	attack_left = !attack_left


func _input(event):
	if Input.is_action_just_pressed("tap"):
		print("test")
		if can_attack:
			attack()
			can_attack = false


func update_speed():
	speed = base_speed * exp(time_alive/100)
	speed.y = clamp(speed.y, -max_speed, 0)
	
	
	pass
	#time_between_spawn = base_time_between_spawn *  exp(-$Player.time_alive/25) + rand_range(0, time_randomness)



func _on_Play_pressed():
	start_pos = position.y
	pass # replace with function body

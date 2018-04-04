extends KinematicBody2D

var speed = Vector2(0, -5)

# -1 = left | 1 = right
var attack_left = true
var can_attack = true
var attack_speed = .3


func _ready():
	
	pass

func _process(delta):
	move_and_collide(speed)


func _on_Tween_tween_completed(object, key):
	print("Done")
	can_attack = true


func attack():
	$Tween.interpolate_property($Sword, "rotation_degrees",
		  $Sword.rotation_degrees, -180 * int(attack_left),
		  attack_speed,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	
	$Tween.start()
	attack_left = !attack_left


func _input(event):
	if Input.is_action_just_pressed("tap"):
		print("test")
		if can_attack:
			attack()
			can_attack = false



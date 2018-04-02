extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = Vector2(0,-100)


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func _process(delta):
	move_and_collide(speed * delta);
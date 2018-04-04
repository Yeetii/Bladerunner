extends Node

func _ready():
	pass

func _process(delta):
	if (int($Player.position.y) % 1000 <= 1):
		print("passed")		 
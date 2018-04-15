extends "res://Scripts/Enemy.gd"

export (int) var move_spread
export (int) var move_spread_randomness

var timer = 0
var side_movement_speed
var side_movement_random

func _ready():
	side_movement_speed = rand_range(1, 10)
	side_movement_random = rand_range(0, move_spread_randomness)

func move(delta):
	timer += delta
	position.y += speed * delta
	position.x += (move_spread + side_movement_random) * sin(timer * side_movement_speed) * delta
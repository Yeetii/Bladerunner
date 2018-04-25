extends "res://Scripts/Enemy.gd"

export (int) var move_spread
export (int) var move_spread_randomness

var timer = 0
var side_movement_speed
var side_movement_random

var random_sin_offset

func _ready():
	side_movement_speed = rand_range(1, 10)
	side_movement_random = rand_range(0, move_spread_randomness)
	
	random_sin_offset = rand_range(0, 2)

func move(delta):
	timer += delta*2
	position.y += (speed + (speed*2) * sin(timer + random_sin_offset)) * delta    #speed * delta
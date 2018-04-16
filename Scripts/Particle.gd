extends Node2D

var life_time

func _ready():
	life_time = $Particles2D.lifetime
	$Particles2D.one_shot = true
	$Particles2D.emitting = true
	

func _process(delta):
	life_time -= delta
	if life_time < 0:
		queue_free()
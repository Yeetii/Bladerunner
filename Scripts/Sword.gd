extends Area2D



func _ready():
	pass




func _on_Sword_area_entered(area):
	area.queue_free()
	pass

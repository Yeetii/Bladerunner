extends Area2D



func _ready():
	
	pass


func _on_Enemy_area_entered(area):
	if area.get_parent().get_name() == "Sword":
		queue_free()


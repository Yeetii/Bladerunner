extends Sprite

var desired_position = Vector2()

func _ready():
	
	
	pass


func start():
	desired_position = get_tree().root.get_node("Main/UI/GoldInformation/Sprite").get_global_transform_with_canvas().get_origin()
	
	$Tween.interpolate_property(self, "global_position", global_position, desired_position, 1.5, Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	Global.add_gold(1)
	queue_free()

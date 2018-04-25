extends Sprite

var fade_out = false
var time = 1

func _ready():
	pass


func _process(delta):
	if fade_out:
		time-=delta
		self_modulate.a = time
		if time <= 0:
			queue_free()


func spawn(sprite, target):
	texture = sprite
	
	$Tween.interpolate_property(self, "scale", Vector2(0,0), Vector2(3,3), 1, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.interpolate_property(self, "global_position", global_position, target, 1, Tween.TRANS_QUAD, Tween.EASE_IN)
	
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	fade_out = true
	pass # replace with function body

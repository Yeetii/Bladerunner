extends Sprite

var fade_out_timer = false
var fade = false
var alpha = 1

func _process(delta):
	if fade_out_timer:
		fade_out_timer -= delta
		if fade_out_timer <= 0:
			fade = true
	
	if fade:
		alpha = lerp(alpha, 0, delta * 10)
		self_modulate.a = alpha
		
		if alpha < 0.1:
			queue_free()
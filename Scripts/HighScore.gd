extends Label

var time = 0

func _ready():
	if Global.high_score == 0:
		queue_free()
	text = "High Score: " + str(Global.high_score)
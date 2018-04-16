extends Label

func _ready():
	Global.connect("update_gold", self, "update_text")

func update_text(gold):
	text = str(gold)
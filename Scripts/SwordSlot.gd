extends TextureButton

var data = {}

func _ready():
	
	pass

func _on_SwordSlot_button_down():
	
	pass # replace with function body


func create(sword_data):
	data = sword_data
	update()

func update():
	$CenterContainer/TextureRect.texture = data.texture
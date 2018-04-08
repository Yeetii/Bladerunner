extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var restart_scene

func _ready():
	show()
	play("out")
	pass

func play(in_or_out):
	if in_or_out == "in":
		restart_scene = true
		$AnimationPlayer.play_backwards("Transition")
	elif in_or_out == "out":
		restart_scene = false
		$AnimationPlayer.play("Transition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if restart_scene:
		get_tree().reload_current_scene()
	queue_free()
	pass # replace with function body

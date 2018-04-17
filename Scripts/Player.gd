extends KinematicBody2D

var energy = 100
var max_energy = 100
var can_regen_energy = true

signal energy_changed(new_energy)

var base_speed = Vector2(0, -3)
var speed = Vector2(0, -3)

var start_pos

var kills = 0

var attack_left = true
var can_attack = true
var attack_speed = .2

var time_alive = 0

export var max_speed = 10

var equiped_sword


func _ready():
	Global.connect("update_sword", self, "equip_sword")
	equiped_sword = $Sword.get_children()[0]
	pass

func _process(delta):
	
	move_and_collide(speed)
	
	if Global.is_playing:
		time_alive += delta
		update_speed()
	
	if can_regen_energy:
		add_energy(10*delta)


func _on_Tween_tween_completed(object, key):
	can_attack = true


func attack():
	$Tween.interpolate_property($Sword, "rotation",
		  $Sword.rotation, -PI * int(attack_left),
		  equiped_sword.attack_speed,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	$Tween.start()
	attack_left = !attack_left
	add_energy(- equiped_sword.energy_cost)


func _input(event):
	if event.is_pressed():
		if can_attack && can_regen_energy:
			attack()
			can_attack = false


func update_speed():
	speed = base_speed * exp(time_alive/100)
	speed.y = clamp(speed.y, -max_speed, 0)


func _on_Play_pressed():
	start_pos = position.y


func die():
	print("Player dead")
	
	var camera = $Camera2D
	var camera_offset = camera.position
	remove_child(camera)
	get_parent().add_child(camera)
	camera.position = position + camera_offset
	
	
	Global.is_playing = false
	get_parent().restart()
	queue_free()

func _on_energy_timer_timeout():
	can_regen_energy = true
	

func has_energy():
	if not can_regen_energy:
		return energy - equiped_sword.energy_cost > 0

func add_energy(value):
	energy += value
	
	if energy < 0:
		$energy_timer.start()
		can_regen_energy = false
	
	energy = clamp(energy, 0, max_energy)
	#if energy < max_energy:
		#$energy_timer.start()
	emit_signal("energy_changed", energy)

func equip_sword(sword):
	# Make function work with all weapons
	#var current_weapon = $Sword.get_children()[0]
	# Remove old sword
	if $Sword.get_children().size() > 0:
		$Sword.get_children()[0].queue_free()
	# Add new sword
	print("begore crash ", + sword)
	print("a--------------------",Global.data.equiped_sword.scene)
	var new_sword = Global.data.equiped_sword.scene.instance()
	#var new_sword = Global.sword_wood.instance()
	$Sword.add_child(new_sword)
	equiped_sword = new_sword
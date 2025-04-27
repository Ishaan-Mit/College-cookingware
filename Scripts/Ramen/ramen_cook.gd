extends Node2D

var cuts_done = 0
var game_done = false
var mode = "green onion"
var sin_tracker = 0
var egg_cut_list = []
@onready var knife: Area2D = $"Knife"
@onready var egg: Area2D = $Egg/Egg
@onready var egg_2: Area2D = $Egg/Egg2
@onready var egg_3: Area2D = $Egg/Egg3


func _ready() -> void:
	mode = "green onion"
	SceneManager.stop_sfx()
	$"Green Onion".position = Vector2(0,0)
	$Egg.position = Vector2(0,0)
	$Pork.position = Vector2(0,0)
	$Egg.hide()
	$Pork.hide()

func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()

func _on_knife_cuts_done() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_drop_colander.tscn", "drain!")
	


func _process(delta: float) -> void:
	if mode == "green onion":
		if cuts_done >= 18:
			set_process_input(false)
			cuts_done = 0
			knife.position = Vector2(450, 324)
			mode = "egg"
			$Egg.show()
			var tween = get_tree().create_tween()
			tween.tween_property($"Green Onion", "position:y", 300, 1)
			await tween.finished
			tween.kill()
			$"Green Onion".hide()
			set_process_input(true)

	if mode == "egg":
		sin_tracker += delta
		knife.position.x = sin(sin_tracker)*90 + 350
		if cuts_done == 3:
			set_process_input(false)
			knife.position = Vector2(450, 300)
			mode = "pork"
			$Pork.show()
			var tween = get_tree().create_tween()
			tween.tween_property($"Egg", "position:y", 300, 1)
			await tween.finished
			tween.kill()
			$Egg.hide()
			cuts_done = 0
			set_process_input(true)
	
	if mode == "pork":
		if Input.is_action_pressed("mouse_left"):
			var mouse_pos = get_global_mouse_position()
			if mouse_pos.distance_to(knife.position) <= 30:
				knife.position = Vector2(min(mouse_pos[0], 450), 300)
			if knife.position.x <= 220:
				_on_knife_cuts_done()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mode == "green onion":
			SceneManager.play_sfx("res://assets/audio/chop.wav")
			knife.position.x -= 10
			knife.position.y += 50
			await get_tree().create_timer(0.1).timeout
			knife.position.y -= 50
			cuts_done += 1
		
		elif mode == "egg":
			SceneManager.play_sfx("res://assets/audio/chop.wav")
			knife.position.y += 50
			await get_tree().create_timer(0.1).timeout
			knife.position.y -= 50
			if len(knife.get_overlapping_areas()) > 0:
				egg = knife.get_overlapping_areas()[0] 
				if egg in [egg, egg_2, egg_3] and egg not in egg_cut_list:
					SceneManager.play_sfx("res://Assets/audio/grabnew.wav")
					egg_cut_list.append(egg)
					cuts_done += 1

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

func _on_timer_time_done() -> void:
	if not game_done:
		SceneManager.change_scene_defeat()
		game_done = true

func _on_knife_cuts_done() -> void:
	if not game_done:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_egg.tscn", "boil!")
		game_done = true

func _process(delta: float) -> void:
	$Label.text = "Cuts: " + str(cuts_done)
	if mode == "green onion":
		if cuts_done >= 18:
			set_process_input(false)
			cuts_done = 0
			knife.position = Vector2(441, 324)
			mode = "egg"
			var tween = get_tree().create_tween()
			tween.tween_property($"Green Onion", "position:y", 300, 1)
			await tween.finished
			tween.kill()
			set_process_input(true)

	if mode == "egg":
		sin_tracker += delta
		knife.position.x = sin(sin_tracker)*90 + 350
		

func _input(event):
	if mode == "green onion":
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SceneManager.play_sfx("res://assets/audio/chop.wav")
			knife.position.x -= 10
			knife.position.y += 50
			await get_tree().create_timer(0.1).timeout
			knife.position.y -= 50
			cuts_done += 1
	elif mode == "egg":
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SceneManager.play_sfx("res://assets/audio/chop.wav")
			knife.position.y += 50
			await get_tree().create_timer(0.1).timeout
			knife.position.y -= 50
			if len(knife.get_overlapping_areas()) > 0:
				egg = knife.get_overlapping_areas()[0] 
				if egg in [egg, egg_2, egg_3] and egg not in egg_cut_list:
					egg_cut_list.append(egg)
					cuts_done += 1
		

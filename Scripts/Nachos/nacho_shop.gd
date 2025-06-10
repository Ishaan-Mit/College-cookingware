extends Node2D

@onready var grid: GridContainer = $ColorRect/GridContainer

var row = 0
var col = 0
var used_coords = []
var needed = ["Tortillas", "Oil", "Nacho Cheese", "Milk"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/GridContainer/TextureButton5.grab_focus()

func col_select(col_num):
	col = col_num
	$ColorRect/GridContainer/TextureButton2.grab_focus()

func row_select(row_num):
	row = row_num
	var item = grid.get_child(row*4+col)
	if !SceneManager.has_ingredient(item.text):
		SceneManager.add_ingredient(item.text)
	item.modulate = Color("ffffff00")
	SceneManager.play_sfx("res://Assets/audio/grab.wav")
	$ColorRect/GridContainer/TextureButton5.grab_focus()
	print(SceneManager.ingredients)
	used_coords.append([col, row])
	
	if len(SceneManager.ingredients) >= 9:
		SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "mix!", 1)

func _on_texture_button_pressed() -> void:
	row_select(0)

func _on_texture_button_2_pressed() -> void:
	row_select(1)

func _on_texture_button_3_pressed() -> void:
	row_select(2)

func _on_texture_button_4_pressed() -> void:
	col_select(1)

func _on_texture_button_5_pressed() -> void:
	col_select(2)
	
func _on_texture_button_6_pressed() -> void:
	col_select(3)

func _on_timer_time_done() -> void:
	for item in needed:
		if not SceneManager.has_ingredient(item):
			SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "chop!", 1, false)
			break
	SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "chop!", 1)

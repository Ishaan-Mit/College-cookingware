extends Node2D

@export var targetCuts = 5
var game_done = false
@onready var knife: Sprite2D = $"Knife"


func _ready() -> void:
	SceneManager.stop_sfx()

func _on_timer_time_done() -> void:
	if not game_done:
		SceneManager.change_scene_defeat()
		game_done = true

func _on_knife_cuts_done() -> void:
	if not game_done:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_egg.tscn", "boil!")
		game_done = true


func _input(event):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SceneManager.play_sfx("res://assets/audio/chop.wav")
		knife.position.x -= 10
		knife.position.y += 50
		await get_tree().create_timer(0.1).timeout
		knife.position.y -= 50

extends Node2D

@export var targetCuts = 5
var game_done = false

func _on_timer_time_done() -> void:
	if not game_done:
		SceneManager.change_scene_defeat()
		game_done = true

func _on_knife_cuts_done() -> void:
	if not game_done:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_fill.tscn")
		game_done = true

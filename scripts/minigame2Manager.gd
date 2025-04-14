extends Node2D

@export var targetCuts = 5


func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()

func _on_knife_cuts_done() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_fill.tscn")

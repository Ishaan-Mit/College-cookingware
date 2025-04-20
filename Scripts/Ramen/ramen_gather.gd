extends Node2D

func _on_timer_time_done() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_fill.tscn", "fill!")

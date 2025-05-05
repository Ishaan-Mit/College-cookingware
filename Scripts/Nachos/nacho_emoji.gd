extends Node2D


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2)

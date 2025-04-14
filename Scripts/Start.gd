extends Control

func _on_button_pressed() -> void:
	print("start")
	SceneManager.change_scene_success("res://scenes/recipes.tscn")

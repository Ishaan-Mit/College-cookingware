extends Control


func _on_ramen_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_gather.tscn", "gather!")
	

func _on_home_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/start.tscn")

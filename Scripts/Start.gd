extends Control

func _on_button_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/recipes.tscn")
	SceneManager.play_music("res://Assets/audio/funkyhuhsample.wav")

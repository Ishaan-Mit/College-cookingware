extends Button

func _on_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/start.tscn")
	SceneManager.play_sfx("res://assets/audio/click.wav")

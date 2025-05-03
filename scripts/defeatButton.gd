extends Button

func _on_pressed() -> void:
	SceneManager.update_lives(-1)
	SceneManager.change_scene("res://Scenes/start.tscn")
	SceneManager.play_sfx("res://assets/audio/click.wav")
	SceneManager.clear_ingredients()

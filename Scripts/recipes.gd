extends Control


func _on_ramen_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_gather.tscn", "gather!")
	SceneManager.play_music("res://Assets/audio/ramen_bgm.wav")
	SceneManager.play_sfx("res://Assets/audio/click.wav")

func _on_home_pressed() -> void:
	SceneManager.change_scene_success("res://Scenes/start.tscn")
	SceneManager.play_sfx("res://Assets/audio/click.wav")

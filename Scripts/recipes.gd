extends Control


func _on_ramen_pressed() -> void:
	SceneManager.update_lives(3)
	SceneManager.change_scene("res://Scenes/Ramen/ramen_gather.tscn", "gather!", 1)
	SceneManager.play_music("res://Assets/audio/ramen_bgm.wav")
	SceneManager.play_sfx("res://Assets/audio/click.wav")

func _on_nachos_pressed() -> void:
	SceneManager.update_lives(3)
	SceneManager.change_scene("res://Scenes/Nachos/nacho_shop.tscn", "shop!", 4)
	SceneManager.play_music("res://Assets/audio/nacholevel2.wav")
	SceneManager.play_sfx("res://Assets/audio/click.wav")

	
func _on_home_pressed() -> void:
	SceneManager.update_lives(-1)
	SceneManager.change_scene("res://Scenes/start.tscn")
	SceneManager.play_sfx("res://Assets/audio/click.wav")

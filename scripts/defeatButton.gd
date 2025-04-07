extends Button

func _on_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/startmenu.tscn")
	

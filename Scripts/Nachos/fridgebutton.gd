extends TextureButton

func _on_riffraff_pressed():
	self.hide()
	SceneManager.play_sfx("res://Assets/audio/grabnew.wav")

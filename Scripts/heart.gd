extends Control

func drain():
	SceneManager.play_sfx("res://Assets/audio/waterfill.wav")
	$AnimatedSprite2D.play("drain")
	await get_tree().create_timer(1).timeout
	hide()
	
func reveal():
	show()
	$AnimatedSprite2D.play("full")

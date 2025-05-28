extends Control

func drain():
	SceneManager.play_sfx("res://Assets/audio/waterfill.wav")
	$AnimatedSprite2D.play("drain")
	


func _on_animated_sprite_2d_animation_finished() -> void:
	hide()

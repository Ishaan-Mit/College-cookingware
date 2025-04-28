extends Node2D
@onready var rating_label: Label = $RatingLabel

var lives = SceneManager.lives
func _ready() -> void:
	SceneManager.play_sfx("res://Assets/audio/srank.wav")
	if lives == 3:
		rating_label.text = "Your Rating: S"
	elif lives == 2:
		rating_label.text = "Your Rating: A"
	elif lives == 1:
			rating_label.text = "Your Rating: C"

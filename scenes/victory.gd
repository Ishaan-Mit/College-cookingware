extends Node2D

@onready var label = $RatingLabel

var rating = "X"

func CalculateRating():
	if(GameManager.remainingTime > 4):
		rating = "S"
	else: if(GameManager.remainingTime > 3):
		rating = "A"
	else: if(GameManager.remainingTime > 2):
		rating = "B"
	else: if(GameManager.remainingTime > 1):
		rating = "C"
	else:
		rating = "D"

func _ready():
	CalculateRating()
	label.text = "Your Rating:" + str(rating)

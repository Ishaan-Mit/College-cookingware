extends Node2D

class_name minigame3Manager

static var instance: minigame3Manager #gathering mini game

@export var targetTime = "300"

var currentString = "";
func _ready():
	minigame3Manager.instance = self

func addNum(num: String):
	currentString += num
	print(currentString)
	if(currentString.length() == 3):
		if currentString == targetTime:
			GameManager.finishMinigame(TimerModule.instance.getRemainingTime())
		else:
			GameManager.goToDefeat()

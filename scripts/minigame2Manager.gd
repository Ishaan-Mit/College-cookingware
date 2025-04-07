extends Node2D

class_name minigame2Manager

static var instance: minigame2Manager #gathering mini game

@export var targetCuts = 5

var currentCuts = 0;

var isDown = false

func _ready():
	minigame2Manager.instance = self

func increment():
	currentCuts+=1
	if(currentCuts >= targetCuts):
		GameManager.finishMinigame(TimerModule.instance.getRemainingTime())
	print(currentCuts)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not isDown:
		isDown = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		isDown = false
		increment()

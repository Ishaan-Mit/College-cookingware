extends Node2D

class_name minigame1Manager

static var instance: minigame1Manager #gathering mini game

@export var totalItems = 5

var currentItems = 0;

func _ready():
	minigame1Manager.instance = self

func increment():
	currentItems+=1
	if(currentItems == totalItems):
		GameManager.finishMinigame(TimerModule.instance.getRemainingTime())
	print(currentItems)

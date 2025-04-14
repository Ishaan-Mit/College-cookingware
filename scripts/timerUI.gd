extends Node2D

class_name TimerModule

static var instance: TimerModule

#load the timer and timerLabel (aka the ui element to the timer)
@onready var timer = $Timer
@onready var label = $TimerLabel

func _ready():
	label.text = str(snapped(timer.time_left, 0.01))
	TimerModule.instance = self

func _process(_delta):
	label.text = str(snapped(timer.time_left, 0.01))
	if(timer.time_left <= 0):
		pass

func getRemainingTime():
	return snapped(timer.time_left, 0.01)

extends Node2D

@export var meterSpeed = 20
var meterMax = 40
var meterMiddle = meterMax/2

@onready var Meter = $MeterBackground/Meter
@onready var SweetSpot = $MeterBackground/SweetSpot
var retracting = false

@export var sweetSpotSize1 = 5
@export var sweetSpotSize2 = 3
@export var sweetSpotSize3 = 2
var stage = 1
var sweetSpotLowerBound = 0
var sweetSpotUpperBound = 0

@onready var successLabels = [$Egg1Label, $Egg2Label, $Egg3Label] 
var fails = 0

func _ready() -> void:
	calculateSweetSpotBounds(sweetSpotSize1)
	stage = 1

func _process(delta: float) -> void:
	moveMeter(delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# print(charsToDisplay)
		checkMeter()
		stage += 1
		match stage:
			2:
				calculateSweetSpotBounds(sweetSpotSize2)
			3:
				calculateSweetSpotBounds(sweetSpotSize3)
				#end game here (win)
			_:
				#end game here  
				calculateSweetSpotBounds(sweetSpotSize3)

func checkMeter():
	if(Meter.size.x >= sweetSpotLowerBound && Meter.size.x <= sweetSpotUpperBound):
		print("success")
		successLabels[stage - 1].get_node("Check").visible = true
	else:
		print("fail")
		fails += 1
		successLabels[stage - 1].get_node("Cross").visible = true
		if(fails >= 2):
			SceneManager.change_scene_defeat()
	print(Meter.size.x)

func moveMeter(delta: float) -> void:
	#check if retracting
	if(Meter.size.x <= 0):
		retracting = false
	if(Meter.size.x >= meterMax):
		retracting = true
	#move the bar
	if(Meter.size.x < meterMax && !retracting):
		Meter.size.x += meterSpeed * delta
	else: if(Meter.size.x > 0 && retracting):
		Meter.size.x -= meterSpeed * delta
	#print(Meter.size.x)

func calculateSweetSpotBounds(newSize: float):
	sweetSpotLowerBound = meterMiddle - (newSize / 2)
	sweetSpotUpperBound = meterMiddle + (newSize / 2)
	print(sweetSpotLowerBound)
	SweetSpot.position.x = sweetSpotLowerBound
	SweetSpot.size.x = newSize

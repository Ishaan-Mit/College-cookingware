extends Button
@export var number = "0"

func _pressed():
	print("pressed")
	minigame3Manager.instance.addNum(str(number))

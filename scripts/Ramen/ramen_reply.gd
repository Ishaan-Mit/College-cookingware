extends Node2D

var full_text = ""
var full_text_length = 0
@export var targetClicks = 20 #target clicks
@onready var TextBody = $TextBody #get the richtextlabel object

var currentClicks = 0

func _ready() -> void:
	#fetching the fulltext from the txt file
	var file = FileAccess.open("res://Assets/misc/dummytext.txt", FileAccess.READ)
	if file:
		full_text = file.get_as_text()
		file.close()
		full_text_length = full_text.length()
		TextBody.text = ""

#mouse detection
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		currentClicks += 1
		var charsToDisplay = (full_text_length/targetClicks) * currentClicks
		# print(charsToDisplay)
		var display = full_text.substr(0, charsToDisplay)
		TextBody.text = "[color=black]" + display + "[/color]" #displays text
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if currentClicks >= targetClicks:
				print("win")
				SceneManager.change_scene_success("res://Scenes/Ramen/ramen_cook_pork.tscn", "cook!")

#failure...
func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()

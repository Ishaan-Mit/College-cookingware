extends Node2D

@export var targetClicks = 20 # Target clicks
@onready var TextBody = $TextBody # Get the richtextlabel object

var currentClicks = 0
var full_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla"


func _process(_delta: float) -> void:
	var charsToDisplay = (ceil(full_text.length()/targetClicks)) * currentClicks
	var display = full_text.substr(0, charsToDisplay)
	
	TextBody.text = "[color=black][code]" + display + "[/code][/color]" #displays text
	
	if currentClicks >= targetClicks:
		SceneManager.change_scene("res://Scenes/Ramen/ramen_cook_pork.tscn", "cook!", 1)

#keyboard detection
func _input(event):
	if event is InputEventKey and event.pressed:
		currentClicks += 1
		SceneManager.play_sfx("res://Assets/audio/typing2.wav")

#failure...
func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Ramen/ramen_cook_pork.tscn", "cook!", 1, false)

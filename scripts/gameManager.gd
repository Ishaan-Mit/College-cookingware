extends Node

var remainingTime = 0

#minigames to load to iterate through, load into this when you load a level?
var scenes = [
	preload("res://scenes/game_1.tscn"),
	preload("res://scenes/game_2.tscn"),
	preload("res://scenes/game_3.tscn")
]

# tracks current scene index as you iterate
var current_scene_index = 0 

func reset_game():
	current_scene_index = 0 
	remainingTime = 0;

func changeToNextMinigame():
	current_scene_index+=1;
	if(current_scene_index < scenes.size()):
		get_tree().change_scene_to_packed(scenes[current_scene_index])
	else:
		get_tree().change_scene_to_file("res://scenes/victory.tscn")

func addRemainingTime(amount: float):
	remainingTime += amount

func finishMinigame(timeRemaining: float):
	addRemainingTime(timeRemaining)
	print(remainingTime)
	changeToNextMinigame()

func goToDefeat():
	get_tree().change_scene_to_file("res://scenes/defeat.tscn")
	reset_game()

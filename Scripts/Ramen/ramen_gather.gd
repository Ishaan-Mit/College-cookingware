extends Node2D

@onready var people: Node2D = $People

func _on_timer_time_done() -> void:
	print(SceneManager.ingredients)
	if SceneManager.has_ingredient("Ramen"):
		SceneManager.change_scene("res://Scenes/Ramen/ramen_fill.tscn", "fill!", 1)
	else:
		SceneManager.change_scene("res://Scenes/Ramen/ramen_fill.tscn", "fill!", 1, false)

func _process(_delta: float) -> void:
	if randi_range(1, 100) == 14:
		person_move()
		
func person_move():
	print("make")
	var person = preload("res://Scenes/Ramen/ramen_guy_shopper.tscn")
	if randi_range(1,2) == 1:
		person = preload("res://Scenes/Ramen/ramen_lady_shopper.tscn")
	people.add_child(person.instantiate())

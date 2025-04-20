extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneManager.has_ingredient("Egg"):
		SceneManager.change_scene_success("res://Scenes/recipes.tscn")

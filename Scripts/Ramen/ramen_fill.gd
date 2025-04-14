extends Node2D

@onready var button: Button = $Button
@onready var pan: Sprite2D = $Pan
var fill_level = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button.button_pressed:
		fill_level += 1
	pan.frame = fill_level/20
	
func _on_timer_time_done() -> void:
	if pan.frame == 3:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_drop.tscn")
	else:
		SceneManager.change_scene_defeat()
	

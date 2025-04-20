extends Node2D

@onready var button: Button = $Button
@onready var pan: Sprite2D = $Pan
var fill_level = 0

func _ready() -> void:
	fill_level = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button.button_pressed:
		fill_level += 1
	pan.frame = int(fill_level/20)
	
func _on_timer_time_done() -> void:
	if pan.frame == 3:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_drop.tscn", "drop!")
	else:
		SceneManager.change_scene_defeat()

func _on_button_button_up() -> void:
	if pan.frame != 3:
		fill_level += 5
	pass # Replace with function body.

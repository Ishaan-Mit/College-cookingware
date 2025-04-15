extends Node2D

@onready var uncookedramen: Area2D = $Ramen
var tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = get_tree().create_tween().set_loops(14)
	
	tween.tween_property(uncookedramen, "position:x", -300, randf_range(1, 3)).as_relative()
	tween.tween_property(uncookedramen, "position:x", 300, randf_range(1, 3)).as_relative()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		tween = get_tree().create_tween()
		tween.tween_property(uncookedramen, "position:x", 0, 0.001).as_relative()
		tween.tween_property(uncookedramen, "position:y", 130, 0.3).as_relative()

func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()

func _on_pan_area_entered(area: Area2D) -> void:
	if area == uncookedramen:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_egg.tscn")

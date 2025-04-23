extends Node2D

@onready var ramen: Area2D = $Ramen

@onready var polygon: Polygon2D = $Polygon2D
var tween
var moving = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ramen.position = Vector2(0,-50)
	tween = get_tree().create_tween().set_loops()
	tween.tween_property(polygon, "position:x", -300, randf_range(0.7, 1.5)).as_relative()
	tween.tween_property(polygon, "position:x", 300, randf_range(0.7, 1.5)).as_relative()
	SceneManager.play_sfx("res://Assets/audio/boiling.wav")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		tween = get_tree().create_tween()
		ramen.position.x = polygon.position.x
		tween.tween_property(ramen, "position:y", 218, 0.5)

func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()
	SceneManager.stop_sfx()

func _on_pan_area_entered(area: Area2D) -> void:
	if area == ramen:
		SceneManager.play_sfx2("res://assets/audio/splash.wav")
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_chop.tscn", "chop!")

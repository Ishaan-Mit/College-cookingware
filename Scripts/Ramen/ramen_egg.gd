extends Node2D

@onready var arrow: Area2D = $arrow
@onready var arrow_2: Area2D = $arrow2
@onready var good: Area2D = $good
@onready var bad: Area2D = $bad

var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if not SceneManager.has_ingredient("Egg"):
	#	SceneManager.change_scene_success("res://Scenes/recipes.tscn")
	tween = get_tree().create_tween().set_loops()
	tween.tween_property(arrow, "position:y", -104, randf_range(0.4,1)).as_relative()
	tween.tween_property(arrow, "position:y", 104, randf_range(0.4, 1)).as_relative()
	SceneManager.stop_sfx()
	SceneManager.play_sfx("res://Assets/audio/boiling.wav")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if arrow.overlaps_area(good):
			arrow_2.position.y -= 30
			SceneManager.play_sfx2("res://Assets/audio/stokeflame2.wav")
		else:
			arrow_2.position.y += 15
			SceneManager.play_sfx2("res://assets/audio/stokeflame.wav")
		arrow_2.position.y = max(40, arrow_2.position.y)
		arrow_2.position.y = min(224, arrow_2.position.y)
		
func _on_timer_time_done() -> void:
	if arrow_2.position.y >= 80 or arrow_2.position.y <= 128:
		SceneManager.change_scene_success("res://Scenes/Ramen/ramen_chop.tscn", "chop!")
	else:
		SceneManager.change_scene_defeat()
		

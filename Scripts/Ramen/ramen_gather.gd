extends Node2D

func _on_timer_time_done() -> void:
	SceneManager.change_scene_success("res://Scenes/Ramen/ramen_fill.tscn", "fill!")
	
func _process(delta: float) -> void:
	if randi_range(1, 100) == 14:
		lady_move()
		
func lady_move():
	print("make")
	var sprite = Sprite2D.new()
	var tween = get_tree().create_tween()
	sprite.position = Vector2(-120, 350)
	sprite.texture = load("res://Assets/ladysilouette.png")
	tween.tween_property(sprite, "position:y", 100, 3)
	sprite.queue_free()
	pass

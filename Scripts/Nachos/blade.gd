extends Node2D

@export var max_points := 20
@onready var line = $Line2D

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print("lmb")
		line.add_point(event.position)
		#print(event.position)
		if line.points.size() > max_points:
			line.remove_point(0)
		_check_slice(event.position)
	elif event is InputEventMouseButton and not event.pressed:
		line.clear_points()

func _check_slice(pos: Vector2) -> void:
	if line.points.size() < 2:
		return
	var from = line.points[line.points.size() - 2]
	var to = line.points[line.points.size() - 1]
	var hit = get_world_2d().direct_space_state.intersect_ray(PhysicsRayQueryParameters2D.create(from, to, 1)) 
	if hit and hit.has("collider"):
		var body = hit.collider
		if body and body.has_method("slice"):
			body.slice()

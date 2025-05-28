extends Node2D

@onready var knifemark: Line2D = $Knifemark

var cuts_done = 0
var cutting = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tortilla1.show()
	$Tortilla2.hide()
	$Tortilla3.hide()
	$Tortilla4.hide()
	$Tortilla5.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("mouse_left") and cutting:
		knifemark.add_point(get_local_mouse_position())

func good_cut():
	cuts_done += 1
	var distances: int= 0
	for i in range(knifemark.get_point_count()):
		distances += knifemark.get_point_position(i).distance_squared_to(Vector2(320, 256))
	var sqrtdist = sqrt(distances)
	knifemark.clear_points()
	var quality = []
	if sqrtdist < 500:
		quality.append("Good!")
	elif sqrtdist < 1000:
		quality.append("Ok!")
	else:
		quality.append("Not Good!")
	get_node("Tortilla" + str(cuts_done)).hide()
	get_node("Tortilla" + str(cuts_done+1)).show()
	
	if cuts_done == 4:
		SceneManager.change_scene("res://Scenes/Nachos/nacho_emoji.tscn", "Rizz!", 1)


func _on_start_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			cutting = true
			knifemark.add_point(get_local_mouse_position())
		elif not event.pressed:
			cutting = false
			knifemark.clear_points()
	
func _on_middle_mouse_exited() -> void:
	cutting = false
	knifemark.clear_points()

func _on_end_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if cutting:
			good_cut()
			cutting = false


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_emoji.tscn", "Rizz!", 1, false)

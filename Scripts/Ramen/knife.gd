extends Sprite2D

var init_pos = Vector2(340, 262)
var cutting_pos = Vector2(342, 157)
var cuts = 0
signal cuts_done
@export var cuts_needed = 10
func _ready():
	position = init_pos

func _input(event):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SceneManager.play_sfx("res://assets/audio/chop.wav")
		position = cutting_pos
		cuts += 1
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		position = init_pos
	if cuts >= cuts_needed:
		cuts_done.emit()

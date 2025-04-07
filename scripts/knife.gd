extends Sprite2D

var init_pos = Vector2(340, 262)
var cutting_pos = Vector2(342, 157)

func _ready():
	position = init_pos

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		position = cutting_pos
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		position = init_pos

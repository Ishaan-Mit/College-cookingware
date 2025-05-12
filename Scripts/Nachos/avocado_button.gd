extends TextureButton

class_name Avocado

var is_dragging = false
var is_mashable = false  
var offset = Vector2()

var min_x = 250
var max_x = 377
var min_y = 227
var max_y = 296

@export var clicks = 3
var currentClicks = 0

signal button_disappeared()

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS

func _process(delta: float) -> void:
	if is_dragging:
		position = get_viewport().get_mouse_position() - (size * scale)/2
	if position.x >= min_x and position.x <= max_x and position.y >= min_y and position.y <= max_y:
		is_mashable = true
		#print("mashable")
	else:
		is_mashable = false
		#print("not mashable")

func _on_button_down() -> void:
	is_dragging = true
	#print("dragging")

func _on_button_up() -> void:
	is_dragging = false
	#print("stopped dragging")

func _on_pressed() -> void:
	if is_mashable:
		currentClicks += 1
		if(currentClicks >= clicks):
			emit_signal("button_disappeared") 
			self.hide()

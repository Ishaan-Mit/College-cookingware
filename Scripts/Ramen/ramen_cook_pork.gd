extends Node2D

@onready var button: Button = $Button
@onready var arrow: Area2D = $Arrow
@onready var good_temp: Area2D = $GoodTemp
@onready var raw: Polygon2D = $Pork/Raw
@onready var middle: Polygon2D = $Pork/Middle
@onready var cooked: Polygon2D = $Pork/Cooked
@onready var burnt: Polygon2D = $Pork/Burnt
@onready var flip_label: Button = $FlipButton

var temperature = 100
var cook_temp = 0
var flipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temperature = 100
	cook_temp = 0
	flip_label.hide()
	middle.hide()
	cooked.hide()
	burnt.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button.button_pressed:
		temperature += 1
	else:
		temperature -= 0.3
	
	temperature = min(max(temperature,0), 256)
	arrow.position.x = 376 + temperature
	
	if arrow.overlaps_area(good_temp):
		cook_temp += delta
	
	if cook_temp < 3:
		raw.show()
		middle.hide()
		cooked.hide()
	elif cook_temp < 6:
		middle.show()
	elif cook_temp < 12:
		if flipped:
			SceneManager.change_scene_success("res://Scenes/Ramen/ramen_boil_egg.tscn", "boil!")
		cooked.show()
		flip_label.show()
	else:
		burnt.show()
		await get_tree().create_timer(0.5).timeout
		SceneManager.change_scene_defeat()

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.text = "Stove: On"
	else:
		button.text = "Stove: Off"

func _on_flip_button_pressed() -> void:
	if cook_temp > 6 and cook_temp < 12:
		flipped = true
		cook_temp = 0
		flip_label.hide()

func _on_timer_time_done() -> void:
	SceneManager.change_scene_defeat()

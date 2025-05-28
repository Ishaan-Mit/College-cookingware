extends Node2D

@export var numObjects = 40
@export var xLowerBound = 0
@export var xUpperBound = 345
@export var yLowerBound = 0
@export var yUpperBound = 256

@export var x2LowerBound = 0
@export var x2UpperBound = 345
@export var y2LowerBound = 0
@export var y2UpperBound = 256

@export var playAreas: Array[ColorRect]
@onready var playArea = $PlayArea

@onready var avocado = $Avocado
@export var buttonZ = 0

@export var sampleButtons: Array[TextureButton] = []

@onready var root = $NachoFridge

func _ready() -> void:
	randomize()
	for i in numObjects: #make random rectangles
		makeRect(i * 1.2, randi() % 2)
	randomizeTBPosition(avocado,randi() % 2)
	avocado.z_index = buttonZ

func makeRect(z_index: float, playAreaIndex: int):
	var template = sampleButtons[randi() % sampleButtons.size()]
	var rect = template.duplicate()
	rect.mouse_filter = Control.MOUSE_FILTER_PASS 
	#var width = randf_range(36,100)
	#var height = randf_range(36,100)
	#rect.custom_minimum_size = Vector2(width, height)
	
	add_child(rect)
	var pos_x
	var pos_y
	if(playAreaIndex == 0):
		pos_x = randf_range(xLowerBound, xUpperBound)
		pos_y = randf_range(yLowerBound, yUpperBound)
	else:
		pos_x = randf_range(x2LowerBound, x2UpperBound)
		pos_y = randf_range(y2LowerBound, y2UpperBound)
	rect.global_position = Vector2(pos_x, pos_y)
	
	#rect.add_color_override("font_color", Color(randf(), randf(), randf()))
	
	rect.z_index = z_index

func randomizeTBPosition(object: TextureButton, playAreaIndex: int):
	#playAreas[playAreaIndex].add_child(object)
	var pos_x
	var pos_y
	if(playAreaIndex == 0):
		pos_x = randf_range(xLowerBound, xUpperBound)
		pos_y = randf_range(yLowerBound, yUpperBound)
	else:
		pos_x = randf_range(x2LowerBound, x2UpperBound)
		pos_y = randf_range(y2LowerBound, y2UpperBound)
	object.position = Vector2(pos_x, pos_y)
	var console: String = str(playAreaIndex + 1) + " "+ str(pos_x) +  " " + str(pos_y)
	print(console)
	

func _on_avocado_pressed() -> void:
	SceneManager.play_sfx2("res://Assets/audio/wingrab.wav")
	SceneManager.change_scene("res://Scenes/Nachos/nacho_mash.tscn", "mash!", 1)


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_mash.tscn", "mash!", 1, false)

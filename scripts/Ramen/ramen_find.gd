extends Node2D

@export var numObjects = 20
@export var xLowerBound = 0
@export var xUpperBound = 345
@export var yLowerBound = 0
@export var yUpperBound = 256
@export var buttonZ = 35
@onready var playArea = $PlayArea

@onready var cuttingBoard = $PlayArea/CuttingBoard
@onready var collander = $PlayArea/Collander

@onready var cuttingBoardUI = $TargetUI/CuttingBoard
@onready var collanderUI = $TargetUI/Collander

var targetItems = 2
var currenttItems = 0

func _ready() -> void:
	randomize()
	cuttingBoard.z_index = buttonZ
	collander.z_index = buttonZ
	for i in numObjects: #make random rectangles
		makeRect(i * 1.2)
	
	randomizeTBPosition(cuttingBoard)
	randomizeTBPosition(collander)

func makeRect(z_index: float):
	var rect = ColorRect.new()
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE 
	var width = randf_range(36,100)
	var height = randf_range(36,100)
	rect.custom_minimum_size = Vector2(width, height)
	
	var pos_x = randf_range(xLowerBound, xUpperBound)
	var pos_y = randf_range(yLowerBound, yUpperBound)
	rect.position = Vector2(pos_x, pos_y)
	
	rect.color = Color(randf(), randf(), randf())
	
	rect.z_index = z_index
	playArea.add_child(rect)

func randomizeTBPosition(object: TextureButton):
	var pos_x = randf_range(xLowerBound, xUpperBound)
	var pos_y = randf_range(yLowerBound, yUpperBound)
	object.position = Vector2(pos_x, pos_y)

func _process(_delta: float) -> void:
	if(currenttItems >= targetItems):
		SceneManager.change_scene("res://Scenes/Ramen/ramen_chop.tscn", "chop!", 1)
		# print("win go next minigame")

func _on_cutting_board_pressed() -> void:
	cuttingBoard.hide()
	cuttingBoardUI.hide()
	#SceneManager.add_ingredient(self.name)
	SceneManager.play_sfx("res://Assets/audio/grabnew.wav")
	# print("cutting board grab")
	currenttItems += 1


func _on_collander_pressed() -> void:
	collander.hide()
	collanderUI.hide()
	#SceneManager.add_ingredient(self.name)
	SceneManager.play_sfx("res://Assets/audio/grabnew.wav")
	# print("collander board grab")
	currenttItems += 1


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Ramen/ramen_chop.tscn", "chop!", 1, false)

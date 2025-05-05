extends Node2D

@onready var waterbucket_1: Sprite2D = $Waterbucket1
@onready var cheese_bag: Polygon2D = $Cheese/cheeseBag
@onready var fallingcheese: Polygon2D = $Cheese/cheeseBag/fallingcheese
@onready var cheeseprogress: TextureProgressBar = $Cheese/cheeseprogress

@onready var milk: Node2D = $Milk
@onready var milk_bag: Polygon2D = $Milk/milkBag
@onready var fallingmilk: Polygon2D = $Milk/milkBag/fallingmilk
@onready var milkprogress: TextureProgressBar = $Milk/milkprogress

@onready var swap: Button = $Swap

var pouring = false
var mode = "cheese"

func _ready() -> void:
	cheese_bag.rotation = 0
	fallingcheese.hide()
	cheeseprogress.value = 0
	milk_bag.hide()
	fallingmilk.hide()

func _process(_delta: float) -> void:
	if pouring and swap.button_up:
		if mode == "cheese":
			cheeseprogress.value += 0.5
		elif mode == "milk":
			milkprogress.value += 0.5

func _unhandled_input(event: InputEvent) -> void:
	if mode == "cheese":
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			cheese_bag.rotation = -PI/4
			fallingcheese.show()
			pouring = true
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			cheese_bag.rotation = 0
			fallingcheese.hide()
			pouring = false
	elif mode == "milk":
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			milk_bag.rotation = -PI/4
			fallingmilk.show()
			pouring = true
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			milk_bag.rotation = 0
			fallingmilk.hide()
			pouring = false

func _on_swap_pressed() -> void:
	if mode == "milk":
		if milkprogress.value > 55 and milkprogress.value < 69 and cheeseprogress.value > 55 and cheeseprogress.value < 69:
			SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "cut!", 2)
		else:
			SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "cut!", 2, false)
	elif mode == "cheese":
		cheese_bag.hide()
		fallingcheese.hide()
		milk_bag.show()
		mode = "milk"
		swap.text = "Finish"

func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_tortilla.tscn", "cut!", 2, false)

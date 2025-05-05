extends Node2D

@export var WrongEmojis: Array[CompressedTexture2D]
@export var WrongButtons: Array[Button]
@export var Buttons: Array[Button]
@export var ButtonPositions: Array[Node2D]

func _ready() -> void:
	randomize()
	#random sprites
	var startIndex := randi() % WrongEmojis.size()
	for i in WrongButtons:
		var sprite:= i.get_node("Sprite") as Sprite2D
		sprite.set_texture(WrongEmojis[++startIndex])
		sprite.scale = Vector2(0.05, 0.05)
		startIndex = (startIndex + 1) % WrongEmojis.size()
	#random positions
	randomize()
	startIndex = randi() % Buttons.size()
	for i in range(0, Buttons.size(), 1):
		Buttons[i].position = ButtonPositions[startIndex].position
		startIndex = (startIndex + 1) % ButtonPositions.size()

func _on_timer_time_done() -> void:
	print("lose here to time")
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2, false)
func _on_heart_pressed() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2)

func _on_wrong_button_pressed() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2, false)

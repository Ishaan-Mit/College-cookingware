extends Node2D

var row_counter := 0
var col_counter := 0
var rock := false
var counter : float = 0
var input_mode = "spatula"
@onready var spatula: Polygon2D = $Spatula
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var boulder: Polygon2D = $Rock
@onready var rock_hit: Area2D = $Rock/Rock_hit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spatula.position = Vector2(250, 165)
	$Arrow.hide()
	
func _process(delta: float) -> void:
	if rock:
		counter += delta
		boulder.position = Vector2((320 + sin(counter)*120), 48)
		
func do_chips():
	input_mode = "none"
	$Arrow.show()
	animation.play("move_beef")
	await animation.animation_finished
	$Beef.hide()
	rock = true
	counter = 0
	input_mode = "rock"

func drop_boulder():
	rock = false
	await get_tree().create_timer(0.1).timeout
	await get_tree().create_tween().tween_property(boulder, "position:y", 408, 0.3).finished
	
	await get_tree().create_timer(6).timeout
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2, false)
	
	
func _unhandled_input(event: InputEvent) -> void:
	if input_mode == "none":
		pass
	elif input_mode == "spatula":
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			spatula.position.y += 15
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			SceneManager.play_sfx("res://Assets/audio/crunch.wav")
			col_counter += 1
			if col_counter == 3:
				spatula.position.y += 20
				spatula.position.x = 250
				col_counter = 0
				row_counter += 1
			else:
				spatula.position.x += 20
				spatula.position.y -= 15
			if row_counter == 3:
				do_chips()
	elif input_mode == "rock":
		SceneManager.play_sfx("res://Assets/audio/throw.wav")
		drop_boulder()
		rock = false
		

func _on_arrow_hit_area_entered(area: Area2D) -> void:
	if area == rock_hit and input_mode == "rock":
		animation.play("flip_chips")
		await animation.animation_finished
		SceneManager.play_sfx("res://Assets/audio/ding.wav")
		SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2)


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_ninja.tscn", "chop!", 2, false)

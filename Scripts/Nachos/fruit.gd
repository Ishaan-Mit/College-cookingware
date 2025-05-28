extends RigidBody2D

@export var initialSpeed := Vector2.ZERO
@export var half1: PackedScene
@export var half2: PackedScene

func _ready() -> void:
	linear_velocity = initialSpeed

func slice():
	if(name == "Onion"):
		print("onion fail")
		SceneManager.play_sfx3("res://Assets/audio/squish.wav")
		SceneManager.play_sfx2("res://Assets/audio/scream.wav")
		SceneManager.change_scene("res://Scenes/Nachos/nacho_plate.tscn", "plate!", 1, false)
	var half1 = half1.instantiate()
	var half2 = half2.instantiate()
	half1.global_position = global_position
	half2.global_position = global_position
	get_parent().add_child(half1)
	get_parent().add_child(half2)
	
	var strength = 150                     
	var dir1 = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	var dir2 = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()

	half1.apply_impulse(Vector2.ZERO, dir1 * strength)
	half2.apply_impulse(Vector2.ZERO, dir2 * strength)
	queue_free()

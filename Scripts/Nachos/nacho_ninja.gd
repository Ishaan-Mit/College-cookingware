extends Node2D

@export var fruit_scenes: Array[PackedScene]
@export var throwForce = 0
@export var fruitsAtTime = 1
@onready var spawnTimer = $SpawnTimer

func _ready() -> void:
	spawnTimer.start()

func _on_spawn_timer_timeout() -> void:
	for i in range(fruitsAtTime):
		var fruit = fruit_scenes[randi() % fruit_scenes.size()].instantiate()
		fruit.initialSpeed = Vector2(randf_range(-50,50), -1 * randf_range(throwForce-200,throwForce+100 ))
		fruit.position = Vector2( randf_range(100, get_viewport_rect().size.x - 100), get_viewport_rect().size.y)
		#print(fruit.position)
		add_child(fruit)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body && body.name != "Onion" && body.get_script().resource_path.ends_with("fruit.gd") :
		print("fruit" + body.name + "entered lose here")


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_fridge.tscn", "find!", 1)
	# print("win here")
	return

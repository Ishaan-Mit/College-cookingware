extends TextureButton

var is_dragging = false
var last_position = Vector2()
var velocity = Vector2()
var last_time = 0.0

var can_produce = true

@export var spawnTimer: Timer

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS 

func _process(delta: float) -> void:
	if is_dragging:
		position = get_viewport().get_mouse_position() + (size * scale)/2
	var current_position = position
	velocity = (current_position - last_position) / delta
	last_position = current_position
	#if(velocity.y != 0): print(velocity)
	if((velocity.y >= 70) && can_produce): 
		var half1 = load("res://Scenes/Nachos/fruits/tomatojalapeno.tscn").instantiate()
		half1.global_position = global_position + Vector2(0, -100) - (Vector2(size.x, -size.y)* scale)/2 
		get_parent().add_child(half1)
		half1.name = "TJ"
		can_produce = false
		spawnTimer.start(0.2)


func _on_button_down() -> void:
	is_dragging = true
	print("dragging")


func _on_button_up() -> void:
	is_dragging = false
	print("stopped dragging")


func _on_timer_timeout() -> void:
	can_produce = true

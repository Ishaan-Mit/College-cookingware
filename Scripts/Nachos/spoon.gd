extends TextureButton

var is_dragging = false
var last_position = Vector2()
var velocity = Vector2()
var last_time = 0.0

var can_produce = true


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS 
	

func _process(delta: float) -> void:
	if is_dragging:
		position = get_viewport().get_mouse_position() + (Vector2(size.x - 450, 0)* scale)/2
	var current_position = position
	last_position = current_position


func _on_button_down() -> void:
	is_dragging = true
	print("dragging")


func _on_button_up() -> void:
	is_dragging = false
	print("stopped dragging")
	$Spoonmeat.visible = false
	var half1 = load("res://Scenes/Nachos/fruits/meat.tscn").instantiate()
	half1.global_position = global_position + (Vector2(size.x - 100, -size.y + 100)* scale)/2 
	get_parent().add_child(half1)
	half1.name = "meat"
	can_produce = false

func _on_meatbowl_area_entered(area: Area2D) -> void:
	print(area.name)
	if(area.name.contains("spoon")):
		print("meat scooped")
		$Spoonmeat.visible = true
		can_produce = true

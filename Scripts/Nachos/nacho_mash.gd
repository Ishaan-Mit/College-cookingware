extends Node2D

@export var bowl_area: Area2D
@export var bowl: AnimatedSprite2D
@export var avocados: Array[Area2D] = []  # Array to store all avocado buttons
var click_count = 0
var max_clicks = 3  # Number of clicks needed to trigger the action

func _ready() -> void:
	print("ready")

# Advance the bowl's animation
func advance_bowl_animation() -> void:
	var sprite_frames = bowl.sprite_frames
	var total_frames = sprite_frames.get_frame_count(bowl.animation)
	if bowl.frame < total_frames - 2:
		bowl.frame += 1
	else:
		bowl.frame += 1
		print("win here!")

func _on_bowl_area_body_entered(body: Node2D) -> void:
	print("body entered")
	if body in avocados:
		print(body.name + " entered the bowl area!")
		var button = body.get_node("Avocado")
		button.is_mashable = true
		print("Avocado Entered")

func _on_bowl_area_body_exited(body: Node2D) -> void:
	if body in avocados:
		print(body.name + " left the bowl area!")
		var button = body.get_node("Avocado")
		button.is_mashable = false
		print("Avocado Exited")


func _on_bowl_area_area_entered(area: Area2D) -> void:
	print("area entered")
	if area in avocados:
		print(area.name + " entered the bowl area!")
		var button = area.get_node("Avocado")
		button.is_mashable = true
		print("Avocado Entered")


func _on_bowl_area_area_exited(area: Area2D) -> void:
	print("area exit")
	if area in avocados:
		print(area.name + " exited the bowl area!")
		var button = area.get_node("Avocado")
		button.is_mashable = false
		print("Avocado Exited")


func _on_avocado_button_button_disappeared() -> void:
	advance_bowl_animation()


func _on_timer_time_done() -> void:
	print("lose here")

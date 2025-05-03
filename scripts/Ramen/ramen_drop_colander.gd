extends Node2D

@onready var ramen: Area2D = $Ramen

@onready var arrow = $Arrow

@export var arrowSpeed = 20
@export var lowerXBound = 0
@export var upperXBound = 100
@export var timeToDrop = 0.3
var retracting = false

var frozen = false

func _on_colander_area_entered(area: Area2D) -> void:
	if area == ramen:
		SceneManager.play_sfx("res://Assets/audio/successedit.wav")
		ramen.hide()
		SceneManager.change_scene("res://Scenes/Ramen/ramen_victory.tscn")
		SceneManager.play_music("res://Assets/audio/goofyrecorderbit.wav")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		frozen = true
		#move ramen to position
		ramen.position = arrow.position
		var tween = get_tree().create_tween()
		tween.tween_property(ramen, "position:y", 305, 0.75)
		SceneManager.play_sfx("res://Assets/audio/throw.wav")

func _process(delta: float) -> void:
	if(!frozen): moveArrow(delta)

func moveArrow(delta: float) -> void:
	#check if retracting
	if(arrow.position.x <= lowerXBound):
		retracting = false
	if(arrow.position.x  >= upperXBound):
		retracting = true
	#move the arrow
	if(arrow.position.x  < upperXBound && !retracting):
		arrow.position.x  += arrowSpeed * delta
	else: if(arrow.position.x  > lowerXBound && retracting):
		arrow.position.x  -= arrowSpeed * delta
	#print(Meter.size.x)


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Ramen/ramen_victory.tscn", "", 0, false)

extends Control
class_name timeLogic
@onready var progress: TextureProgressBar = $Progress
@export var time: float = 10
var time_left : float = 0
var deltaTime = 1
signal time_done
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 8
	time *= 100.0/74.0

func _process(delta: float) -> void:
	time_left += delta*deltaTime
	progress.value = min(74, 100*time_left/time)
	if progress.value >= 74:
		time_done.emit()

extends Control

@onready var progress: TextureProgressBar = $Progress
@export var time: int = 10
var time_left = 0
signal time_done
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 0
	
	

func _process(delta: float) -> void:
	time_left += delta
	progress.value = min(100, 100*time_left/time)
	if time_left >= time:
		time_done.emit()

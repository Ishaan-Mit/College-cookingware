extends Control

@onready var progress: TextureProgressBar = $Progress
@export var time: int = 10
signal time_done
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 0
	var tween = get_tree().create_tween()
	tween.tween_property(progress, "value", 100, time)
	await tween.finished
	time_done.emit()

extends Node2D


@onready var pan: AnimatedSprite2D = $Pan
@onready var water_drag: HSlider = $WaterDrag
@onready var pipe: Node2D = $Pipe
@onready var particles: GPUParticles2D = $Pipe/GPUParticles2D

var fill_level = 0
var time_track = 0

func _ready() -> void:
	particles.emitting = true
	particles.emitting = false

	fill_level = 0
	particles.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_track += delta*1.5
	pan.position.x = 450 + 70 * sin(time_track)
	pipe.position.x = 330+water_drag.value
	
	if particles.emitting and abs(pan.position.x-pipe.position.x) < 40:
		fill_level += 0.5
		if(!SceneManager.is_sfx_playing()): SceneManager.play_sfx("res://Assets/audio/waterfill.wav")
	
	pan.frame = min(6,int(fill_level/30))

func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Ramen/ramen_drop.tscn", "drop!", 1, pan.frame == 4)

func _on_water_drag_drag_started() -> void:
	particles.emitting = true


func _on_water_drag_drag_ended(_value_changed: bool) -> void:
	particles.emitting = false

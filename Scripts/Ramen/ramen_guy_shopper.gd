extends Sprite2D

var speed = randi_range(6,10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(750, 400)
	var scale_num = randf_range(0.5,1)
	scale = Vector2(scale_num, scale_num)
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if position.x > -100:
		position.x -= speed
	else:
		queue_free()

extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var instruction: Label = $Instruction

var ingredients = []

func _ready() -> void:
	self.process_mode = PROCESS_MODE_ALWAYS
	instruction.scale = Vector2(0,0)

func change_scene_success(target: String, text: String = ""):
	var tween = get_tree().create_tween()
	anim.play("scene_fade")
	await anim.animation_finished
	get_tree().change_scene_to_file(target)
	get_tree().paused = true
	if text != "":
		instruction.text = text.capitalize()
		anim.play("text_pop")
		await anim.animation_finished
	anim.play_backwards("scene_fade")
	await anim.animation_finished
	get_tree().paused = false
	

func change_scene_defeat():
	anim.play("scene_fade")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/defeat.tscn")
	anim.play_backwards("scene_fade")

func add_ingredient(ingredient: String):
	ingredients.append(ingredient)
	
func has_ingredient(ingredient: String):
	return ingredient in ingredients

extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

var ingredients = []



func change_scene_success(target: String, instruction: String = ""):
	anim.play("scene_fade")
	await anim.animation_finished
	get_tree().change_scene_to_file(target)
	anim.play_backwards("scene_fade")

func change_scene_defeat():
	anim.play("scene_fade")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/defeat.tscn")
	anim.play_backwards("scene_fade")

func add_ingredient(ingredient: String):
	ingredients.append(ingredient)
	
func has_ingredient(ingredient: String):
	return ingredient in ingredients

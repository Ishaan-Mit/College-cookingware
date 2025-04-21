extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var instruction: Label = $Instruction
@onready var fx = $FXPlayer
@onready var fx2 = $FXPlayer2
@onready var music = $MusicPlayer

var ingredients = []

func _ready() -> void:
	self.process_mode = PROCESS_MODE_ALWAYS
	instruction.scale = Vector2(0,0)

func change_scene_success(target: String, text: String = ""):
	var _tween = get_tree().create_tween()
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
	SceneManager.play_music("res://assets/audio/goofyrecorderbit.wav")
	stop_sfx()

func add_ingredient(ingredient: String):
	ingredients.append(ingredient)
	
func has_ingredient(ingredient: String):
	return ingredient in ingredients

func play_sfx(path):
	var sound = load(path)
	fx.stream = sound
	fx.play()

func play_sfx2(path):
	var sound = load(path)
	fx2.stream = sound
	fx2.play()

func play_music(path):
	var sound = load(path)
	music.stream = sound
	music.play()

func stop_sfx():
	fx.stop()
	fx2.stop()

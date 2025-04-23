extends CanvasLayer

var lives = 3

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var instruction: Label = $Background/Instruction
@onready var fx = $FXPlayer
@onready var fx2 = $FXPlayer2
@onready var music = $MusicPlayer

var ingredients = []

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	music.process_mode = Node.PROCESS_MODE_ALWAYS
	fx.process_mode = Node.PROCESS_MODE_ALWAYS
	fx2.process_mode = Node.PROCESS_MODE_ALWAYS

func change_scene_success(target: String, text: String = ""):
	get_tree().paused = true
	instruction.text = text.capitalize()
	anim.play("scene_fade")
	await anim.animation_finished
	if text != "":
		await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file(target)
	anim.play_backwards("scene_fade")
	await anim.animation_finished
	get_tree().paused = false

func change_scene_defeat():
	lives -= 1
	get_tree().paused = true
	instruction.text = ""
	anim.play("scene_fade")
	await anim.animation_finished
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/defeat.tscn")
	anim.play_backwards("scene_fade")
	SceneManager.play_music("res://assets/audio/goofyrecorderbit.wav")
	stop_sfx()
	await anim.animation_finished
	get_tree().paused = false


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

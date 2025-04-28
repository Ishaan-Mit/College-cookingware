extends CanvasLayer

var lives = 3

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var instruction: Label = $Background/Instruction
@onready var live_label: Label = $Background/Lives
@onready var fx = $FXPlayer
@onready var fx2 = $FXPlayer2
@onready var fx3 = $FXPlayer3
@onready var music = $MusicPlayer

var ingredients = []

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
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

func change_scene_defeat(target: String, text: String = ""):
	lives -= 1
	print(lives)
	live_label.text = "Lives: " + str(lives)
	get_tree().paused = true
	instruction.text = text.capitalize()
	if lives == 0:
		instruction.text = ""
	anim.play("scene_fade")
	await anim.animation_finished
	if text != "":
		await get_tree().create_timer(2).timeout
	if lives > 0:
		get_tree().change_scene_to_file(target)
	else:
		get_tree().change_scene_to_file("res://Scenes/defeat.tscn")
	anim.play_backwards("scene_fade")
	await anim.animation_finished
	get_tree().paused = false


func _on_pause_pressed() -> void:
	if get_tree().paused:
		get_tree().paused  = false
	elif !get_tree().paused:
		get_tree().paused = true

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

func play_sfx3(path):
	var sound = load(path)
	fx3.stream = sound
	fx3.play()

func play_music(path):
	var sound = load(path)
	music.stream = sound
	music.play()

func stop_sfx():
	fx.stop()
	fx2.stop()
	fx3.stop()

func is_sfx_playing() -> bool:
	return fx2.playing || fx.playing || fx3.playing

func is_sfx3_playing() -> bool:
	return fx3.playing
func is_sfx2_playing() -> bool:
	return fx2.playing

extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var instruction: Label = $Background/Instruction
@onready var fx = $FXPlayer
@onready var fx2 = $FXPlayer2
@onready var fx3 = $FXPlayer3
@onready var music = $MusicPlayer
@onready var hearts: HBoxContainer = $Background/Hearts

var lives = 3
var ingredients = []

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	music.process_mode = Node.PROCESS_MODE_ALWAYS
	fx.process_mode = Node.PROCESS_MODE_ALWAYS
	fx2.process_mode = Node.PROCESS_MODE_ALWAYS

## File Path to next scene [br]
## Description of next minigame [br]
## Controls: 0: None, 1: Click, 2: Drag, 3: keyboard, 4: Sppace [br]
## success, True: Yes Success, False: Not Success
func change_scene(target: String, text: String = "", controls: int = 0, success: bool = true):
	get_tree().paused = true
	instruction.text = text
	var inst = get_node("Background/Controls/" + str(controls))
	inst.show()
	anim.play("scene_fade")
	await anim.animation_finished
	if text != "" or not success:
		if not success:
			update_lives(lives-1)
			play_sfx("res://Assets/audio/throw.wav")
		await get_tree().create_timer(2).timeout
	if lives != 0:
		get_tree().change_scene_to_file(target)
	else:
		get_tree().change_scene_to_file("res://Scenes/defeat.tscn")
	anim.play_backwards("scene_fade")
	await anim.animation_finished
	inst.hide()
	get_tree().paused = false



func update_lives(health: int):
	lives = health
	for i in hearts.get_child_count():
		if !hearts.get_child(i).visible and i < lives:
			hearts.get_child(i).visible = true
		elif hearts.get_child(i).visible and i >= lives:
			hearts.get_child(i).drain()

func _on_pause_pressed() -> void:
	if get_tree().paused:
		get_tree().paused  = false
	elif !get_tree().paused:
		get_tree().paused = true

func add_ingredient(ingredient: String):
	ingredients.append(ingredient)
	
func has_ingredient(ingredient: String):
	return ingredient in ingredients

func clear_ingredients():
	ingredients = []

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

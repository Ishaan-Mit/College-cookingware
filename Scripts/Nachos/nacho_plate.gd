extends Node2D

var chipLevel = 0
@export var targetChips = 10

@export var targetCheese = 20
var eachTargetCheese: int = 0
var cheeseCount: Array[int] = [0, 0, 0]

@export var targetMeat = 20
var eachTargetMeat: int = 0
var meatCount: Array[int] = [0, 0, 0]

@export var targetTJ = 20
var eachTargetTJ: int = 0
var TJCount: Array[int] = [0, 0, 0]

func _ready() -> void:
	eachTargetCheese = targetCheese/3
	eachTargetMeat = targetMeat/3
	eachTargetTJ = targetTJ/3
	print(eachTargetTJ)

#stage 1: chips
func _on_bowl_area_body_entered(body: Node2D) -> void:
	if(body.name.contains("Chips") && chipLevel < targetChips):
		chipLevel+=1
		body.hide()
		if(chipLevel >= targetChips):
			$BowlArea/ChipSprite.visible = true
			$ChipBag.hide()
			$CheeseBottle.visible = true
			$BowlArea.monitoring = false
	#print("object in bowl")

#stage 2, 3, 4: cheese, meat, and tomato/jalapeno
func _on_chip_sprite_body_entered(body: Node2D) -> void:
	if(body.name.contains("cheese")):
		#print(body.name)
		var rigid_body = body as RigidBody2D
		#if body is RigidBody2D: print("is rb")
		rigid_body.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
		rigid_body.freeze = true
		if(is_cheese_won()):
			#print("cheese won")
			$CheeseBottle.hide()
			$Meatbowl.visible = true
			$Spoon.visible = true
	if(body.name.contains("Meat")): #stage 3 meat
		#print(body.name)
		var rigid_body = body as RigidBody2D
		#if body is RigidBody2D: print("is rb")
		rigid_body.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
		rigid_body.freeze = true
		if(is_meat_won()):
			print("meat won")
			$Meatbowl.hide()
			$Spoon.hide()
			$PicoBowl.visible = true
	if(body.name.contains("TJ")): #stage 4 TJ
		print(body.name)
		var rigid_body = body as RigidBody2D
		#if body is RigidBody2D: print("is rb")
		rigid_body.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
		rigid_body.freeze = true
		if(is_TJ_won()):
				SceneManager.change_scene("res://Scenes/Nachos/nacho_fridge.tscn", "find!", 1)
func _on_left_body_entered(body: Node2D) -> void:
	if(body.name.contains("cheese")):
		cheeseCount[0] += 1
	elif(body.name.contains("Meat")):
		meatCount[0] += 1
	elif(body.name.contains("TJ")):
		TJCount[0] += 1
		print("0: " + str(TJCount[2]))

func _on_middle_body_entered(body: Node2D) -> void:
	if(body.name.contains("cheese")):
		cheeseCount[1] += 1
	elif(body.name.contains("Meat")):
		meatCount[1] += 1
	elif(body.name.contains("TJ")):
		TJCount[1] += 1
		print("1: " + str(TJCount[2]))

func _on_right_body_entered(body: Node2D) -> void:
	if(body.name.contains("cheese")):
		cheeseCount[2] += 1
	elif(body.name.contains("Meat")):
		meatCount[2] += 1
	elif(body.name.contains("TJ")):
		TJCount[2] += 1
		print("2: " + str(TJCount[2]))

func is_cheese_won() -> bool:
	for i in cheeseCount:
		if(i < eachTargetCheese): return false
	return true

func is_meat_won() -> bool:
	for i in meatCount:
		if(i < eachTargetMeat): return false
	return true

func is_TJ_won() -> bool:
	for i in TJCount:
		print(str(i) + " vs "+ str(eachTargetTJ))
		if(i < eachTargetTJ): return false
	return true


func _on_timer_time_done() -> void:
	SceneManager.change_scene("res://Scenes/Nachos/nacho_fridge.tscn", "find!", 1, false)

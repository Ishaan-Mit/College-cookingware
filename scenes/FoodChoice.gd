extends Area2D


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if self.name not in Global.ingredients:
					Global.ingredients.append(self.name)
				print(Global.ingredients)

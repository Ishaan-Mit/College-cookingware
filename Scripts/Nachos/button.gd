extends Button

@export var sentPosition: Node2D
func _on_button_up():
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	self.global_position = sentPosition.global_position
	self.scale = sentPosition.scale
	self.rotation = sentPosition.rotation

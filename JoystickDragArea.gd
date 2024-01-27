extends Area2D

signal dragged(is_pressed: bool)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragged.emit(event.is_pressed())

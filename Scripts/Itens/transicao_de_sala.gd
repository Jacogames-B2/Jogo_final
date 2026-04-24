extends Area2D


var segurando := false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		segurando = event.pressed
		Parallax2d.change_offset(Vector2(20,0))

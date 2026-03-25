extends Area2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		#colocar a logica aqui
		get_tree().change_scene_to_file("res://Cenas/Mapas/mapa_1.tscn")

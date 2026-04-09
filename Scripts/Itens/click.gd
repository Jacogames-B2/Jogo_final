extends Area2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		DialogueManager.show_dialogue_balloon(load("res://dialogos/teste.dialogue"), "start")
		print("objeto clicado hahaha")

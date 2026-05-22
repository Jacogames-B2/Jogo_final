extends Area2D

@export var dialogue_file: String = "res://dialogos/teste1.dialogue"
@export var dialogue_title: String = "inicio"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueManager.show_dialogue_balloon(load(dialogue_file), dialogue_title)

extends Area2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		#DialogueManager.show_dialogue_balloon(load("res://dialogos/teste1.dialogue"), "inicio")
		print("objeto clicado hahaha")
	
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coletaveis"):
		print("Area detectada:", area.name)
		print("Item data:", area.item_data)

		InventoryManager.adicionar_item(area.item_data)

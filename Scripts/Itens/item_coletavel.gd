extends Area2D
@export var item_data: ItemData

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		InventoryManager.adicionar_item(item_data)
		queue_free()
		print(InventoryManager.slots)

func _process(delta: float) -> void:
	if  Input.is_action_just_pressed("ui_accept"):
		InventoryManager.pegar_itens(1,2)

extends Area2D

@export var item_data: ItemData

@export var inventario: Inventory


func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:

		inventario.adicionar_item(item_data)

		queue_free()

extends Area2D

@export var item_data: ItemData

@onready var colisao = $CollisionShape2D


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		InventoryManager.adicionar_item(item_data)
		colisao.set_deferred("disabled", true)
		$AnimatedSprite2D.visible = false

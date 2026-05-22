extends StaticBody2D

@export var id_chave: String = "Chave"

var aberta: bool = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		tentar_abrir()

func tentar_abrir() -> void:
	if aberta:
		return
	for i in range(InventoryManager.slots.size()):
		var item = InventoryManager.slots[i]
		if item != null and item.id == id_chave:
			abrir(i)
			return
	print("Porta trancada. Você precisa da chave.")

func abrir(indice: int) -> void:
	aberta = true
	InventoryManager.slots[indice] = null
	InventoryManager.inventario_atualizado.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	hide()

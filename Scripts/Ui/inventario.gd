extends Panel

class_name Inventory
const HAND_THIN_SMALL_CLOSED = preload("uid://c0ag7iec7khli")
const HAND_THIN_SMALL_POINT = preload("uid://dxrjqvw0kkbal")


func _ready() -> void:
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_POINT, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_DRAG)
	InventoryManager.inventario_atualizado.connect(_sync_from_manager)

var data_bk
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null
		sync_to_manager()


@export var slots: Array[Panel]


func _sync_from_manager() -> void:
	for i in range(slots.size()):
		slots[i].item = InventoryManager.slots[i]
		slots[i].update_ui()


func sync_to_manager() -> void:
	for i in range(slots.size()):
		InventoryManager.slots[i] = slots[i].item

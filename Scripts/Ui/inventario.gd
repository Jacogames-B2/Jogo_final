extends Panel

class_name Inventory
const HAND_THIN_SMALL_CLOSED = preload("uid://c0ag7iec7khli")
const HAND_THIN_SMALL_POINT = preload("uid://dxrjqvw0kkbal")


func _ready() -> void:
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_POINT, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(HAND_THIN_SMALL_CLOSED, Input.CURSOR_DRAG)

var data_bk 
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null


@export var slots: Array[Panel]


func adicionar_item(item: ItemData):

	for slot in slots:

		if slot.item == null:

			slot.item = item
			slot.update_ui()

			print("item adicionado:", item.nome)

			return true

	print("inventário cheio")

	return false

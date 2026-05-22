extends Panel

@onready var icon: TextureRect = $icon
@export var item: ItemData


func _ready() -> void:
	update_ui()

func update_ui() -> void:
	if not item:
		icon.texture = null
		tooltip_text = ""
		return
	icon.texture = item.iconee
	tooltip_text = item.nome


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		if item:
			item = null
			update_ui()
			_sync_to_manager()


func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item:
		return
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(25, 25)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.8)
	set_drag_preview(c)
	icon.hide()
	return self


func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var tmp = item
	item = data.item
	data.item = tmp
	icon.show()
	data.icon.show()
	update_ui()
	data.update_ui()
	_sync_to_manager()


func _sync_to_manager() -> void:
	var inv := get_parent().get_parent().get_parent() as Inventory
	if inv:
		inv.sync_to_manager()

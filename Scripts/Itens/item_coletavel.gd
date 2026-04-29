extends Area2D
<<<<<<< HEAD
@export var item_data: ItemData

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==MOUSE_BUTTON_LEFT:
		InventoryManager.adicionar_item(item_data)
		queue_free()
		print(InventoryManager.slots)

func _process(delta: float) -> void:
	if  Input.is_action_just_pressed("ui_accept"):
		InventoryManager.pegar_itens(1,2)
=======


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
>>>>>>> 8b4655959ab727b63659d4694286d5e8240a02fe

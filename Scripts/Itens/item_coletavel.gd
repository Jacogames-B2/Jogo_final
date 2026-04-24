extends Area2D
@export var item_data: ItemData = ItemData

# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ready() -> void:
	item_data.nome = "jaoo"

extends Node


signal inventario_atualizado

var slots: Array = [null, null, null, null]

func adicionar_item(item: ItemData):
	for i in range(slots.size()):
		if slots[i]==null:
			slots[i]=item
			inventario_atualizado.emit()
			return true
	return false

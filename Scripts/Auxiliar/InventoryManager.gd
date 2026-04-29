extends Node

signal inventario_atualizado

var slots: Array = [null, null, null, null]

func adicionar_item(item: ItemData):
	for i in range(slots.size()):
		if slots[i]==null:
			slots[i]=item
			print("Sucesso")
			inventario_atualizado.emit()
			return true
	return false
 
func pegar_itens(index, index2):
	for i in range(slots.size()):
		if slots[i] != null:
			print("funcionou")
	var itens = ItemData.new()
	itens.juntar_itens(slots[index], slots[index2])
	print(slots[index])
		

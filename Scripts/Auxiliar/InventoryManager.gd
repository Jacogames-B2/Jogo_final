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
 

func pegar_itens(index: int, index2: int):
	var item1 = slots[index]
	var item2 = slots[index2]

	if item1 == null or item2 == null:
		return

	var resultado = verificar_fusao(item1, item2)

	if resultado != null:
		slots[index] = resultado
		slots[index2] = null
		inventario_atualizado.emit()

func verificar_fusao(item1: ItemData, item2: ItemData) -> ItemData:

	if item1.id == "Madeira" and item2.id == "Pedra":
		return preload("res://Cenas/Itens/item/Machado.tres")
	return

func _input(event: InputEvent):
	if event.is_action_pressed("fusao"):
		testar_fusao()

func testar_fusao():
	slots[0] = preload("res://Cenas/Itens/item/Madeira.tres")
	slots[1] = preload("res://Cenas/Itens/item/Pedra.tres")

	print("Antes")
	print(slots)

	pegar_itens(0,1)

	print("Depois")
	print(slots)

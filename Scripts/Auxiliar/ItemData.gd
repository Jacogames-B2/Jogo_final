extends Resource
class_name ItemData

func juntar_itens(item,item2):
	print(item)
	print(item2)

@export var nome: String = ""
@export var iconee: Texture2D
@export var empilhavel: bool = false
@export var max_stack: int = 99

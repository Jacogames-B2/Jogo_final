extends Parallax2D


@onready var transicao = $Transicao_de_sala
var camera: Camera2D




func change_offset(a: Vector2)-> void:
	camera.offset+=a


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera=get_viewport().get_camera_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

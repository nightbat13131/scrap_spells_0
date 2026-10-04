class_name StickerResource_Gem extends StickerResource

@export var _gem_color := Color.AQUA

signal socketed(is_socketed: bool)

var _socket : StickerResource_Socket

func get_gem_color() -> Color: return _gem_color

func set_socket(socket: StickerResource_Socket) -> void:
	_socket = socket
	socketed.emit(_socket != null)

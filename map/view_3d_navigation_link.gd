class_name View3DNavigationLink extends Resource

@export var _link_to : View3D
@export var _button_location: Vector2i
@export var _button_icon : Texture2D
@export var _text: String # debug

func get_link() -> View3D: return _link_to

func get_link_marker() -> Marker3D_Enhanced: 
	if _link_to:
		return _link_to.get_marker()
	return null

func get_button_location() -> Vector2i: return _button_location

func get_icon() -> Texture2D: return _button_icon

func get_text() -> String: return _text

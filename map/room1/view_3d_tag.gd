class_name View3D extends Resource
## Tag to identify 3d Markers without knowning what they are

signal focused_changed(is_focused: bool)

@export var _name : String ## debugging

var _marker: Marker3D_Enhanced
var _is_focused := false : set = set_focus, get = is_focused

func set_marker(node: Marker3D_Enhanced) -> void:
	if _marker:
		print("this resource is setup wrong")
	_marker = node

func get_marker() -> Marker3D: return _marker

func get_view_name() -> String: return _name

func set_focus(is_focused_) -> void: 
	_is_focused = is_focused_
	focused_changed.emit(_is_focused)

func is_focused() -> bool: return _is_focused

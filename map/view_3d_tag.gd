class_name View3D extends Resource
## Tag to identify 3d Markers without knowning what they are

@export var _name : String ## debugging

var _marker: Marker3D_Enhanced

func set_marker(node: Marker3D_Enhanced) -> void:
	if _marker:
		print("this resource is setup wrong")
	_marker = node

func get_marker() -> Marker3D: return _marker

func get_view_name() -> String: return _name

class_name Marker3D_Enhanced extends Marker3D


@export var _neighbors : Array[View3DNavigationLink]
@export var _info : View3D

func _ready() -> void:
	if _info:
		_info.set_marker(self)
		#prints(_info.get_view_name(), _neighbors.size())
	else:
		prints(self.name, "has no _info", _neighbors.size())

func get_rand_neighbor() -> Marker3D_Enhanced:
	if !_neighbors.is_empty():
		return _neighbors.pick_random().get_link().get_marker()
	return null

func get_neighbors() -> Array[View3DNavigationLink]: return _neighbors

func get_info() -> View3D: return _info

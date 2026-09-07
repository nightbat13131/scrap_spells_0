class_name RoomUI extends CanvasLayer
## Manage overlays so that when speical overlays are activated, navigation is haulted, 
## and only one speical at a time

@export var _naviation : RoomNavigation3D
@export var _inspection: InspectionUI 

var _is_inspecting := false

func _ready() -> void:
	if _inspection: 
		_inspection.inspecting.connect(_on_inspection_state)
	_update_views()

func _on_inspection_state(is_inspecting: bool): 
	_is_inspecting = is_inspecting
	_update_views()

func _update_views() -> void:
	_naviation.set_visible(!_is_inspecting)

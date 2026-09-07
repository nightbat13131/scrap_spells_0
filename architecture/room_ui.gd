class_name RoomUI extends CanvasLayer
## Manage overlays so that when speical overlays are activated, navigation is haulted, 
## and only one speical at a time

@export var _naviation : RoomNavigation3D
@export var _inspection: InspectionUI 
@export var _book : BookUI

var _is_inspecting := false
var _is_booking := false

func _ready() -> void:
	assert(_inspection and _book and _naviation)
	_inspection.active.connect(_on_inspection_active)
	_inspection.deactivate()
	_book.active.connect(_on_book_active)
	_book.deactivate()
	_naviation.activate()
	_update_views()

func _on_inspection_active(is_inspecting: bool): 
	_is_inspecting = is_inspecting
	if _is_inspecting:
		_book.deactivate()
	_update_views()

func _on_book_active(is_booking: bool): 
	_is_booking = is_booking
	if _is_booking:
		_inspection.deactivate()
	_update_views()


func _update_views() -> void:
	if _is_booking or _is_inspecting:
		_naviation.deactivate()
	else:
		_naviation.activate()

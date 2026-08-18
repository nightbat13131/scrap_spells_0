class_name ViewCameraManager extends Node3D

@export var camera : Camera3D

@export var _initial : Marker3D


#@onready var button_up: Button_NavigateView = %Button_up


@onready var _things : Array[Marker3D_Enhanced] = []

var _last_marker : Marker3D_Enhanced
var _next_marker: Marker3D_Enhanced

static var _instance : ViewCameraManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(camera and _initial, "3d camera manager missing stuff")
	_instance = self
	for each in get_children():
		if each is Marker3D_Enhanced:
			_things.append(each)
	_move_camera(_initial)

func _move_camera(next_marker: Marker3D_Enhanced, fast := true) -> void:
	if next_marker == null:
		return
	if next_marker == _last_marker:
		return
	_next_marker = next_marker
	_leaving_marker()
	if fast:
		__tween_camera_interpolate(1.0)
	else: 
		var tween = create_tween()
		tween.tween_method(__tween_camera_interpolate, 0.0, 1.0, 1.0)
		#print(tween)

static func request_view(next_marker: Marker3D_Enhanced, fast := true) -> void:
	if _instance:
		_instance._move_camera(next_marker, fast)

#method for the tween to do the moving
func __tween_camera_interpolate(weight: float):
	#print(weight)
	if _next_marker == null:
		return
	var _transform: Transform3D = _next_marker.get_global_transform()
	if _last_marker:
		_transform = _last_marker.get_global_transform().interpolate_with(_transform, weight)
	camera.set_global_transform(_transform)
	if is_equal_approx(1.0, weight):
		print("cleanup")
		_ariving_at_marker()

func _ariving_at_marker() -> void:
	_last_marker = _next_marker
	if _last_marker:
		RoomNavigation3D.set_navigation_links(_last_marker.get_neighbors().duplicate())
		_last_marker.get_info().set_focus(true)

func _leaving_marker() -> void:
	RoomNavigation3D.no_links()
	if _last_marker:
		_last_marker.get_info().set_focus(false)

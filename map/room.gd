class_name Room extends Node2D

@export var first_view : RoomViewInfo

@export var camera : Camera2D

var _current_view : RoomViewInfo
var _previous_view : RoomViewInfo

func _ready() -> void:
	assert(first_view)
	request_view(first_view)
	_setup_children()

func _setup_children() -> void:
	for each_child in get_children():
		if each_child is RoomView:
			each_child.set_room(self)

func request_view(next_info: RoomViewInfo) -> void:
	if next_info == null or next_info == _current_view:
		return # no change
	var node := next_info.get_roomview()
	if node == null:
		return 
	for each_child in get_children():
		if each_child is RoomView:
			if each_child == node:
				each_child.activat(camera, _current_view)
				_previous_view = _current_view
				_current_view = next_info
			else:
				each_child.deactivat()

func request_previous_view() -> void:
	request_view(_previous_view)

class_name Room extends Node2D

@export var first_view : RoomView

var _current_view : RoomView
var _previous_view : RoomView



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(first_view)
	request_view(first_view)
	_setup_children()

func _setup_children() -> void:
	for each_child in get_children():
		if each_child is RoomView:
			each_child.set_room(self)

func request_view(node: RoomView) -> void:
	if node == null or _current_view == node:
		return 
	for each_child in get_children():
		if each_child is RoomView:
			if each_child == node:
				each_child.activat()
				_previous_view = _current_view
				_current_view = each_child
			else:
				each_child.deactivat()

func request_previous_view() -> void:
	request_view(_previous_view)

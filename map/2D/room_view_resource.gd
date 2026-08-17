class_name RoomViewInfo  extends Resource

@export var _note : String
@export var valid_previous : Array[RoomViewInfo]
var _last_requseter : RoomViewInfo

var _my_view: RoomView

func set_scene(node: RoomView) -> void:
	_my_view = node

func set_last_requester(info: RoomViewInfo) -> void:
	for each in valid_previous:
		if each == info:
			_last_requseter = info
			return


func get_roomview() -> RoomView: return _my_view

func get_last_requester() -> RoomViewInfo: return _last_requseter

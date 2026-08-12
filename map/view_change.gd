class_name RequestView extends Button

var _room: Room
var _view_info : RoomViewInfo

@export var next_view : RoomViewInfo
@export var only_back := false

func _ready() -> void:
	if next_view == null and !only_back:
		hide()

func set_room(node: Room) -> void:
	_room = node
	if _room:
		if only_back:
			pressed.connect(_request_back)
		elif next_view:
			pressed.connect(_room.request_view.bind(next_view))

func set_room_view(info: RoomViewInfo) -> void: _view_info = info

func _request_back() -> void:
	var next = _view_info.get_last_requester()
	if next:
		_room.request_view(next)
	else:
		_room.request_previous_view()

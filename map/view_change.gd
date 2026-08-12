class_name RequestView extends Button

var _room: Room

@export var next_view : RoomView
@export var only_back := false

func _ready() -> void:
	if next_view == null and !only_back:
		hide()

func set_room(node: Room) -> void:
	_room = node
	if _room:
		if only_back:
			pressed.connect(_room.request_previous_view)
		elif next_view:
			pressed.connect(_room.request_view.bind(next_view))

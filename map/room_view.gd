class_name RoomView extends Node2D

@export var _info : RoomViewInfo


var _room : Room

func _ready() -> void:
	_info.set_scene(self)

func activat(camera: Camera2D = null, requester: RoomViewInfo = null) -> void:
	#show()
	camera.global_position = global_position + Vector2(550,300)
	_info.set_last_requester(requester)
	_able_buttons(false)

func deactivat() -> void:
	_able_buttons(true)
	pass

func set_room(node: Room) -> void:
	_room = node
	for each_child in get_children():
		if each_child is RequestView:
			each_child.set_room(_room)
			each_child.set_room_view(_info)
		elif each_child is RoomView:
			each_child.set_room(_room)

func _able_buttons(do_disable : bool) -> void:
	for each_child in get_children(): 
		if each_child is RequestView:
			each_child.set_disabled(do_disable)
			each_child.set_visible(!do_disable)

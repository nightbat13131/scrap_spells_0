class_name RoomView extends Node2D

var _room : Room

func activat() -> void:
	show()

func deactivat() -> void:
	hide()

func set_room(node: Room) -> void:
	_room = node
	for each_child in get_children():
		if each_child is RequestView:
			each_child.set_room(_room)
	

class_name RoomNavigation3D extends Control

@onready var button_up: Button_NavigateView = %Button_up
@onready var button_left: Button_NavigateView = %Button_left
@onready var button_right: Button_NavigateView = %Button_right
@onready var button_down: Button_NavigateView = %Button_down

@onready var _buttons: Array[Button_NavigateView] = [button_up, button_left, button_right, button_down ]

static var _instance : RoomNavigation3D

func _ready() -> void:
	_instance = self

static func set_navigation_links(links: Array[View3DNavigationLink]) -> void:
	if _instance:
		_instance._set_links(links)

func _set_links(links: Array[View3DNavigationLink]) -> void:
	_deactivate()
	var link: View3DNavigationLink
	while !links.is_empty():
		link = links.pop_back()
		if link == null:
			continue
		match link.get_button_location():
			Vector2i.UP:
				button_up.set_info(link)
			Vector2i.DOWN:
				button_down.set_info(link)
			Vector2i.LEFT:
				button_left.set_info(link)
			Vector2i.RIGHT:
				button_right.set_info(link)
			_ : 
				#prints("no button for ", link.get_text())
				pass

static func no_links() -> void:
	if _instance:
		_instance._deactivate()

func _deactivate() -> void:
	for each in _buttons:
		each.deactivate()

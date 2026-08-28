class_name Inventory extends GridContainer

static var _instance : Inventory

var _show_usables : Array[ShowUsable] = [] 
@export var _button_group : ButtonGroup

@onready var inspect_usable: TextureRect = %InspectUsable
@onready var un_inspect: Button = %UnInspect


func _ready() -> void:
	_instance = self
	un_inspect.pressed.connect(_on_zoom_request.bind(null))
	for each_child in get_children():
		if each_child is ShowUsable:
			_show_usables.append(each_child)
			each_child.set_usable(null)
			each_child.request_zoom.connect(_on_zoom_request)
	_on_zoom_request(null)

func _get_empty_shower() -> ShowUsable:
	for each in _show_usables:
		if !each.has_usable():
			return each
	push_error("no empty found")
	assert(false)
	return null

func _get_current_usable() -> Usable:
	var button := _button_group.get_pressed_button()
	if button:
		if button is ShowUsableButton:
			return button.get_usable()
	return null

static func has_instance() -> bool: return _instance != null

static func get_instance() -> Inventory: return _instance

static func insert_item(thing: Usable) -> void:
	if has_instance() and thing:
		get_instance()._insert_item(thing)

func _insert_item(thing: Usable) -> void:
	if thing:
		prints(thing._note, "inserted")
		_get_empty_shower().set_usable(thing)

static func active_usable_check(thing: Usable) -> bool:
	if has_instance() and thing:
		return get_instance()._active_usable_check(thing)
	return false

func _active_usable_check(thing: Usable) -> bool:
	if thing:
		return thing == _get_current_usable()
	return false

static func remove_item(thing: Usable) -> void:
	if has_instance():
		_instance._remove_item(thing)

func _remove_item(thing: Usable) -> void:
	if thing == null:
		return
	for each in _show_usables:
		if each.match_usable(thing):
			each.set_usable(null)
	_button_group.pressed.emit(null) # helps tell the hand that this is no longer equipabble

func _on_zoom_request(thing: Usable) -> void:
	var texture : Texture2D = null
	if thing:
		texture = thing.get_icon()
	un_inspect.set_visible(texture != null)
	inspect_usable.set_texture(texture)

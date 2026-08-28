class_name ShowUsable extends Control

signal request_zoom(usable: Usable)

var _usable : Usable : set = set_usable


@onready var usable_button: ShowUsableButton = %UsableButton
@onready var inspect_button: Button = %InspectButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	usable_button.set_show_usable(self)
	inspect_button.pressed.connect(_on_zoom_pressed)

func set_usable(thing: Usable) -> void:
	_usable = thing
	usable_button.set_disabled(_usable == null)
	inspect_button.set_disabled(_usable == null)
	inspect_button.set_visible(_usable != null)
	if _usable:
		usable_button.set_button_icon(_usable.get_icon())
	else:
		usable_button.set_button_icon(null)
		usable_button.set_pressed(false)

func has_usable() -> bool: return _usable != null

func get_usable() -> Usable: return _usable

func match_usable(thing: Usable) -> bool: return thing == _usable

func _on_zoom_pressed() -> void:
	if has_usable():
		request_zoom.emit(get_usable())

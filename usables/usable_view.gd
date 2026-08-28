class_name ShowUsable extends Button

var _usable : Usable : set = set_usable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_usable(null)
	pass # Replace with function body.

func set_usable(thing: Usable) -> void:
	_usable = thing
	set_disabled(_usable == null)
	if _usable:
		set_button_icon(_usable.get_icon())
	else:
		set_button_icon(null)
		set_pressed(false)

func has_usable() -> bool: return _usable != null

func get_usable() -> Usable: return _usable

func match_usable(thing: Usable) -> bool: return thing == _usable

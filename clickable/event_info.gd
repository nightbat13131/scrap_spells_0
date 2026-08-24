class_name Event extends Resource

signal triggered(is_triggered_: bool)

@warning_ignore("unused_private_class_variable")
@export var _note: String
@export var _do_toggle := false

var _is_triggered := false: get = is_triggered, set = _set_triggered

func is_triggered() -> bool: return _is_triggered

func trigger() -> void:
	if _do_toggle:
		toggle()
		return
	_is_triggered = true
	prints(is_triggered(), _note)

func un_trigger() -> void:
	_is_triggered = false

func toggle() -> void: _is_triggered = !_is_triggered

func _set_triggered(value: bool) -> void:
	if _is_triggered != value:
		_is_triggered = value
		triggered.emit(_is_triggered)

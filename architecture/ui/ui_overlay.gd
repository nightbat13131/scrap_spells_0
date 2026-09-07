class_name UIOverlay extends Control

signal active(is_active: bool)

var _is_active := false

func activate() -> void:
	show()
	_is_active = true
	active.emit(_is_active)

func deactivate() -> void:
	_is_active = false
	hide()
	active.emit(_is_active)

func toggle_active() -> void:
	if _is_active:
		deactivate()
	else:
		activate()

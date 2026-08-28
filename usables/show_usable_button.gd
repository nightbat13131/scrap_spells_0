class_name ShowUsableButton extends Button

var _show_usable : ShowUsable

func set_show_usable(show_usable: ShowUsable) -> void: _show_usable = show_usable

func get_usable() -> Usable:
	if _show_usable:
		return _show_usable.get_usable()
	return null

class_name Button_NavigateView extends Button


var _info : View3DNavigationLink : set = set_info

func _ready() -> void:
	pressed.connect(_on_pressed)


func deactivate() -> void:
	set_info(null)

func set_info(info: View3DNavigationLink) -> void:
	if info:
		if !info.is_valid():
			info = null
	_info = info
	if _info:
		set_text(_info.get_text())
		show()
	else:
		set_text("")
		hide()

func _on_pressed() -> void:
	if _info:
		_info.trigger_navigation()

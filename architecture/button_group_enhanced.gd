class_name ButtonGroupEnhanced extends ButtonGroup

func _init() -> void:
	pressed.connect(_on_pressed)


func _on_pressed(button: Button) -> void:
	if button:
		if !RoomUI.can_select_inventory():
			force_unpress()
		pass

func force_unpress() -> void:
	var current_button := get_pressed_button()
	if current_button:
		current_button.set_pressed(false) # does not trigger Button Group signal 
	pressed.emit(null) # helps tell the hand that this is no longer equiped

func request_refresh() -> void: pressed.emit(get_pressed_button())

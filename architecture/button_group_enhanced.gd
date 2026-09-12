class_name ButtonGroupEnhanced extends ButtonGroup




func force_unpress() -> void:
	var current_button := get_pressed_button()
	if current_button:
		current_button.set_pressed(false) # does not trigger Button Group signal 
	pressed.emit(null) # helps tell the hand that this is no longer equipabble

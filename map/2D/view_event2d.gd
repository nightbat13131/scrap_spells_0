class_name ViewEvent2D extends Area2D

var _event_state := Utilties.EventStates.INIT


func try_trigger() -> void:
	print('trigger mate', _event_state)

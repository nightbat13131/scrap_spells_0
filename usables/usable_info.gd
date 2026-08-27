class_name Usable extends Resource

@export var _icon : Texture2D
@export var _note : String

@export var _used_by_event : Event

var _is_used_up := false

func get_icon() -> Texture2D: return _icon

func be_looted() -> void:
	prints(_note, "to the inventory")
	Inventory.insert_item(self)

#func is_valid() -> bool: return !_used_by_event

func be_used_up(_event: Event) -> void:
	if _event == _used_by_event:
		_is_used_up = true
		Inventory.remove_item(self)
		prints(_note, "used all up")

func is_equiped() -> bool: return Inventory.active_usable_check(self)

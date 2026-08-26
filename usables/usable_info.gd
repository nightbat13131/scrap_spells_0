class_name Usable extends Resource

@export var _icon : Texture2D

@export var _note : String

func get_icon() -> Texture2D: return _icon

func be_looted() -> void:
	prints(_note, "to the inventory")
	Inventory.insert_item(self)

func be_equiped() -> void:
	prints(_note, "in hand")

func be_unequiped() -> void:
	prints(_note, "out hand")

func be_used_up() -> void:
	prints(_note, "used all up")

func is_equiped() -> bool: return Inventory.active_usable_check(self)

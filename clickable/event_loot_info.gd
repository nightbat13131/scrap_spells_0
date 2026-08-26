class_name EventLoot extends Event

@export var _usable_pickup: Usable

#@export var _usable_dependent : Usable

func _init() -> void:
	triggered.connect(_on_triggered)

func _on_triggered(_ignored: bool) -> void:
	if is_triggered():
		prints(_note, "Event_loot")
		if _usable_pickup:
			_usable_pickup.be_looted()

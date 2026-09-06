class_name EventLoot extends Event
# indended to loot usable or sticker, not both
@export var _usable_pickup: Usable
@export var _sticker_pickup : StickerResource

#@export var _usable_dependent : Usable

func _init() -> void:
	triggered.connect(_on_triggered)

func _on_triggered(_ignored: bool) -> void:
	if is_triggered():
		prints(_note, "Event_loot")
		if _usable_pickup:
			_usable_pickup.be_looted()
		if _sticker_pickup:
			_sticker_pickup.be_looted()

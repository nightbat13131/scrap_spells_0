class_name EventLoot extends Event

func _init() -> void:
	triggered.connect(_on_triggered)
	print("AAA")

func _on_triggered(_ignored: bool) -> void:
	if is_triggered():
		print("add to inventory")

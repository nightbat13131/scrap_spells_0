extends MeshInstance3D


@export var event_loot : Event

func _ready() -> void:
	if event_loot:
		event_loot.triggered.connect(_on_event_trigger)

func _on_event_trigger(_is_triggered) -> void:
	if _is_triggered:
		queue_free()

extends Node3D

@export var _event : Event

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_event)
	_event.triggered.connect(_on_triggered)
	set_rotation(Vector3(0,0,0))

func _on_triggered(is_triggered: bool) -> void:
	if is_triggered:
		print("boink")
		set_rotation(Vector3(45,0,0))

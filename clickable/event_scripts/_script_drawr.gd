extends MeshInstance3D
# open drawr when event is triggered
# close drawr when event is untriggered


@export var _event : Event

var _is_drawr_open := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_event)
	_event.triggered.connect(_on_event_triggered)

func _on_event_triggered(is_triggered: bool) -> void:
	if is_triggered:
		_open_drawr()
	else:
		_close_drawr()

func _open_drawr() -> void:
	%drawr.position = Vector3(0, .378, -.35)
	_is_drawr_open = true

func _close_drawr() -> void:
	%drawr.position = Vector3(0, .378, -.13)
	_is_drawr_open = false

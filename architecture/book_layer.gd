class_name BookUI extends UIOverlay

static var _instance : BookUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func has_instance() -> bool: return _instance != null

static func request_toggle() -> void:
	if has_instance():
		_instance.toggle_active()

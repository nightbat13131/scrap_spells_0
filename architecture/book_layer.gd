class_name BookUI extends UIOverlay

static var _instance : BookUI
@onready var book_interactions: BookInteractions = %BookInteractions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self

static func has_instance() -> bool: return _instance != null

static func request_toggle() -> void:
	if has_instance():
		_instance.toggle_active()

func activate() -> void:
	super.activate()
	book_interactions.activate()

func deactivate() -> void:
	super.deactivate()
	book_interactions.deactivate()

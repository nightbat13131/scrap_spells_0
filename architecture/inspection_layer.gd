class_name InspectionUI extends GridContainer
## Absorbes mouse clicks so that environment clicks behind don't activate

signal inspecting(is_inspectiong: bool)

static var _instance : InspectionUI

@onready var un_inspect: Button = %UnInspect
@onready var inspect_usable: TextureRect = %InspectUsable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self
	un_inspect.pressed.connect(_on_request_inspection.bind(null))
	_on_request_inspection(null)

func _on_request_inspection(thing: Usable) -> void:
	var texture : Texture2D = null
	if thing:
		texture = thing.get_icon()
	inspecting.emit(texture != null)
	set_visible(texture != null)
	inspect_usable.set_texture(texture)

static func has_instance() -> bool: return _instance != null

static func get_instance() -> InspectionUI:
	return _instance

static func request_inspection(thing: Usable) -> void:
	if has_instance():
		_instance._on_request_inspection(thing)

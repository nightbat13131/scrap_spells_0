class_name InspectionUI extends GridContainer

signal inspecting(state: String)

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
		inspecting.emit(Utilties.STATE_IS_NOT_INSPECTING)
	else:
		inspecting.emit(Utilties.STATE_IS_INSPECTING)
	set_visible(texture != null)
	inspect_usable.set_texture(texture)

static func has_instance() -> bool: return _instance != null

static func get_instance() -> InspectionUI:
	return _instance

static func request_inspection(thing: Usable) -> void:
	if has_instance():
		_instance._on_request_inspection(thing)

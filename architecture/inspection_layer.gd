class_name InspectionUI extends UIOverlay
## Absorbes mouse clicks so that environment clicks behind don't activate

static var _instance : InspectionUI

@onready var un_inspect: Button = %UnInspect
@onready var inspect_usable: TextureRect = %InspectUsable
var _current_thing : Usable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self
	un_inspect.pressed.connect(_on_request_inspection.bind(null))
	_on_request_inspection(null)

func _on_request_inspection(thing: Usable) -> void:
	var texture : Texture2D = null
	if thing:
		if thing == _current_thing: # toggle 
			_on_request_inspection(null)
			return
		
		texture = thing.get_icon()
		activate()
	else:
		deactivate()
	_current_thing = thing
	set_visible(texture != null)
	inspect_usable.set_texture(texture)

static func has_instance() -> bool: return _instance != null

static func get_instance() -> InspectionUI:
	return _instance

static func request_inspection(thing: Usable) -> void:
	if has_instance():
		_instance._on_request_inspection(thing)

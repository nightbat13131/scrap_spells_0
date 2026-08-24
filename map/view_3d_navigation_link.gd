class_name View3DNavigationLink extends Resource

@export var _link_to : View3D
@export var _button_location: Vector2i
@export var _button_icon : Texture2D
@export var _text: String # debug

# do not load as a button if this event is not triggered
@export var _depended_event : Event


func get_link() -> View3D: return _link_to

func get_link_marker() -> Marker3D_Enhanced: 
	if _link_to:
		return _link_to.get_marker()
	return null

func get_button_location() -> Vector2i: return _button_location

func get_icon() -> Texture2D: return _button_icon

func get_text() -> String: return _text

func trigger_navigation() -> void:
	if _link_to:
		if is_valid():
			ViewCameraManager.request_view(_link_to.get_marker(), false)

func is_valid() -> bool:
	if _depended_event:
		return _depended_event.is_triggered()
	return true

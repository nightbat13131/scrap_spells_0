@abstract
class_name Area3D_Mousable extends Area3D
# connect to the triggered signal to do stuff.

signal triggered(mousable: Area3D_Mousable)

# Only work when this view is active
@export var _view_dependency : View3D
# Only work when this event is active
@export var _event_dependency : Event
# Only work when this usable is equiped
@export var _usable_dependency : Usable

func _ready() -> void:
	set_monitorable(false) # other area's don't care what this "doing"
	if _view_dependency:
		_view_dependency.focused_changed.connect(_on_view_change)
	if _event_dependency:
		_event_dependency.triggered.connect(_on_event_change)
	if _usable_dependency:
		_usable_dependency.changed.connect(__uppdate_usabilty)
	input_event.connect(_on_input_event)
	__uppdate_usabilty() 

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if _is_usable():
		if event.is_pressed():
			#print("0000")
			triggered.emit(self)

## useful on inheritance 
func _on_view_change(_is_focused: bool) -> void: __uppdate_usabilty(_is_focused)
## useful on inheritance 
func _on_event_change(_id_triggered: bool) -> void: __uppdate_usabilty(_id_triggered)

func _is_usable() -> bool: 
	if _view_dependency:
		if !_view_dependency.is_focused():
			return false
	if _event_dependency:
		if !_event_dependency.is_triggered():
			return false
	if _usable_dependency:
		if !_usable_dependency.is_equiped():
			return false
	return true

func __uppdate_usabilty(_ignored: bool = true) -> void:
	var _is_do := _is_usable()
	set_visible(_is_do)
	set_monitoring(_is_do)
	set_ray_pickable(_is_do)

@abstract func _on_triggered(_thing: Variant) -> void

class_name Area3D_Mousable extends Area3D

signal triggered(mousable: Area3D_Mousable)

# Only work when this view is active
@export var _view_dependency : View3D



func _ready() -> void:
	set_monitorable(false)
	_on_focus_change(false)
	if _view_dependency:
		_view_dependency.focused_changed.connect(_on_focus_change)
	input_event.connect(_on_input_event)

func _is_dependency_good() -> bool: 
	if _view_dependency:
		return _view_dependency.is_focused()
	return true


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if _is_dependency_good():
		if event.is_pressed():
			triggered.emit(self)


func _on_focus_change(_is_focused: bool) -> void: 
	set_monitoring(_is_focused)
	set_ray_pickable(_is_focused)

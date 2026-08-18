class_name Area3D_Clickable extends Area3D

@export var _view_dependency : View3D
@export var _navigate_on_press : View3DNavigationLink

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)
	pass # Replace with function body.

func _is_dependency_good() -> bool: 
	if _view_dependency:
		return _view_dependency.is_focused()
	return true

#func _on_mouse_entered() -> void: 
	#print("E")
	#if _is_dependency_good():
		#print("EEEEEEEEE")
		#
#
#func _on_mouse_exited() -> void: 
	#print("X")

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if _is_dependency_good():
		if event.is_pressed():
			#print(event)
			if _navigate_on_press:
				_navigate_on_press.trigger_navigation()
	pass # Replace with function body.

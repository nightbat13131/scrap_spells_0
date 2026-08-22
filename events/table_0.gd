extends MeshInstance3D
# press to open drawr when pressed

@export var _action_trigger : Area3D_Mousable
@export var _view_trigger : Area3D_Mousable
var _open_view : View3D


var _is_drawr_open := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _action_trigger:
		_action_trigger.triggered.connect(_action_triggered)
	if _view_trigger:
		_view_trigger.triggered.connect(_view_triggered)

func _is_view_active() -> bool: 
	if _open_view:
		return _open_view.is_focused()
	return true


func _action_triggered(_mousable_: Area3D_Mousable) -> void:
	if !_is_drawr_open:
		_open_drawr()
	else:
		
		_close_drawr()
	print("AA")

func _view_triggered(_mousable_: Area3D_Mousable) -> void:
	_close_drawr()
	print("BB")


func _open_drawr() -> void:
	%drawr.position = Vector3(0, .378, -.35)
	_is_drawr_open = true
	print("OOOO")

func _close_drawr() -> void:
	%drawr.position = Vector3(0, .378, -.13)
	_is_drawr_open = false
	print("CCCC")

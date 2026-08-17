class_name MouseRoomInteractions2d extends Node2D


@onready var area_2d: Area2D = %Area2D

@export_category("GUIDE")
@export var _context: GUIDEMappingContext
@export var _action_trigger_event : GUIDEAction

var _is_active := true
var _event : ViewEvent2D

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)
	if _context:
		GUIDE.enable_mapping_context(_context)
		if _action_trigger_event:
			_action_trigger_event.triggered.connect(_on_trigger_event)

func _process(_delta: float) -> void:
	if !_is_active:
		return
	set_global_position(get_global_mouse_position())

func _draw() -> void:
	var color := Color.RED
	if _event == null:
		color = Color.BLUE
	draw_circle(Vector2.ZERO, 5, color)

func _on_area_entered(node: Node2D) -> void:
	if node is ViewEvent2D:
		_event = node
		queue_redraw()

func _on_area_exited(node: Node2D) -> void:
	if node == _event:
		_event = null
		queue_redraw()

func _on_trigger_event() -> void:
	if !_is_active:
		return
	if _event:
		_event.try_trigger()

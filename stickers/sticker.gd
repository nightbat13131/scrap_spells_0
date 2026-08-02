class_name Sticker extends Area2D

# Mouse click and drag

var _is_get_dragged := false
var _mouse_offset := Vector2.ZERO
var _last_g_position := Vector2.ZERO

func _ready() -> void:
	set_z_index(50)

func _area_test() -> void:
	var is_void := true
	var has_void := false
	for each in get_overlapping_areas():
		if each is StickerTray:
			print("home")
			is_void = false
			reparent(each, true)
		elif each is SpreadView:
			print("spread")
			is_void = false
			reparent(each, true)
	if is_void:
		print("void")
		global_position = _last_g_position


func _process(_delta: float) -> void:
	if _is_get_dragged:
		global_position = get_global_mouse_position() + _mouse_offset

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			_is_get_dragged = true
			_mouse_offset = get_local_mouse_position()*-1
			_last_g_position = global_position
		else:
			_is_get_dragged = false
			_area_test()

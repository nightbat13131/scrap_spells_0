class_name Sticker extends Area2D

signal picked_up(sticker: Sticker)

@onready var sprite_outline: Sprite2D = %SpriteOutline
@onready var sticker_collision: CollisionShape2D = %StickerCollision


var _is_get_dragged := false : set = _set_get_dragged
var _mouse_offset := Vector2.ZERO
var _last_g_position := Vector2.ZERO
var _last_tray_position := Vector2.ZERO
var _spread_num := -1 

@export var _info : StickerResource

func _ready() -> void:
	set_z_index(50)
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func spread_rejected() -> void:
	_spread_num = -1
	if StickerTray.return_to_tray(self):
		sprite_outline.set_modulate(Utilties.STICKER_OUTLINE_TRAY)
		_last_tray_position = position
		_last_g_position = global_position

func is_fully_on_spread() -> bool:
	if _spread_num < 0:
		return false
	for each in get_overlapping_areas():
		if each is OutsideSpread:
			return false
	return true

func set_spread(num: int) -> void: _spread_num = num

func match_spread(spraed: int) -> bool: return spraed == _spread_num

func activate_if_spread(spread: int) -> void:
	if _spread_num == spread:
		_activate()
	else:
		deactivate()

func _activate() -> void:
	show()
	sticker_collision.set_disabled(false)

func deactivate() -> void:
	hide()
	sticker_collision.set_disabled(true)

func set_info(info: StickerResource, use_values) -> void: 
	_info = info
	if use_values:
		position = _info._local_position
		rotation = _info._local_rotation

func get_info() -> StickerResource: return _info

func _area_test() -> void:
	var is_void := true
	var has_void := false
	var color := Utilties.STICKER_OUTLINE_TRAY
	for each in get_overlapping_areas():
		if each is StickerTray:
			print("home")
			is_void = false
			reparent(each, true)
			_spread_num = -1
			_last_tray_position = global_position
		elif each is SpreadView:
			print("spread")
			is_void = false
			each.try_to_stick(self)
		elif each is OutsideSpread:
			has_void = true
	if is_void:
		print("void")
		global_position = _last_g_position
	else:
		if _spread_num < 0:
			color = Utilties.STICKER_OUTLINE_TRAY
		else:
			color = Utilties.STICKER_OUTLINE_BOOK
			if has_void:
				color = Utilties.STICKER_OUTLINE_WARNING
	sprite_outline.set_modulate(color)

func _set_get_dragged(value: bool) -> void:
	if value == _is_get_dragged: 
		return
	_is_get_dragged = value
	if _is_get_dragged:
		picked_up.emit(self)
	else:
		_area_test()

func _process(_delta: float) -> void:
	if _is_get_dragged:
		global_position = get_global_mouse_position() + _mouse_offset

func _on_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			_is_get_dragged = true
			_mouse_offset = get_local_mouse_position()*-1
			_last_g_position = global_position
			viewport.set_input_as_handled() # not sure this is doing anything

func _on_mouse_entered() -> void: sprite_outline.scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void: sprite_outline.scale = Vector2(1, 1)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if _is_get_dragged:
			if !event.is_pressed():
				_is_get_dragged = false
				get_viewport().set_input_as_handled()

class_name Sticker extends Area2D

signal picked_up(sticker: Sticker)

@onready var sprite_outline: Sprite2D = %SpriteOutline
@onready var sticker_collision: CollisionShape2D = %StickerCollision


var _is_get_dragged := false : set = _set_get_dragged
var _last_g_position := Vector2.ZERO
var _last_tray_position := Vector2.ZERO
var _is_mouse_focus := false : set = set_mouse_focus
var _spread_num := -1 

@export var _info : StickerResource

func _ready() -> void:
	set_z_index(50)
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER, true)
	set_collision_mask_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)
	await get_tree().process_frame
	_update_status_color()

func set_info(info: StickerResource, use_values) -> void: 
	_info = info
	if use_values:
		position = _info._local_position
		rotation = _info._local_rotation

func get_info() -> StickerResource: return _info

func _activate() -> void:
	show()
	sticker_collision.set_disabled(false)

func deactivate() -> void:
	hide()
	sticker_collision.set_disabled(true)

func set_spread(num: int) -> void: _spread_num = num

func match_spread(spraed: int) -> bool: return spraed == _spread_num

func activate_if_spread(spread: int) -> void:
	if match_spread(spread):
		_activate()
	else:
		deactivate()

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

func set_mouse_focus(is_focused: bool) -> void: 
	_is_mouse_focus = is_focused
	if _is_mouse_focus:
		sprite_outline.set_scale(Vector2.ONE*1.2)
	else:
		sprite_outline.set_scale(Vector2.ONE)



func try_pickup() -> Sticker:  ## allows some stickers to be locked in place or have other rules
	_is_get_dragged = true
	_last_g_position = global_position
	return self

func release_pickup() -> void: 
	_is_get_dragged = false
	_update_status_color()
	for area in get_overlapping_areas():
		if area is SpreadView:
			area.try_to_stick(self)

func _set_get_dragged(value: bool) -> void:
	if value == _is_get_dragged: 
		return
	_is_get_dragged = value
	if _is_get_dragged:
		picked_up.emit(self)
	else:
		_area_test()
	_update_status_color()

func try_rotation(direction: float) -> void:
	rotation += (direction * TAU / 8.0)
	rotation = snappedf(rotation, TAU / 8.0)

func _update_status_color() -> void:
	var has_tray := false
	var has_spread := false
	var has_void := false
	
	for each_area in get_overlapping_areas():
		if each_area is StickerTray:
			has_tray = true
		elif each_area is SpreadView:
			has_spread = true
		elif each_area is OutsideSpread:
			has_void = true
	
	var color := Color.GREEN
	
	if has_tray:
		color = Utilties.STICKER_OUTLINE_TRAY
	elif has_void:
		color = Utilties.STICKER_OUTLINE_WARNING
	elif has_spread: 
		color = Utilties.STICKER_OUTLINE_BOOK
	else:
		print_debug("no match")
	sprite_outline.set_modulate(color)

func _area_test() -> void:
	return
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

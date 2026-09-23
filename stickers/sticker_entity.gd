class_name StickerEntity extends Area2D
signal request_drop(sticker: StickerEntity)
signal picked_up(sticker: StickerEntity)

@onready var sprite_outline: Sprite2D = %SpriteOutline
@onready var sprite_shadow: Sprite2D = %SpriteShadow
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D

var _is_get_dragged := false : set = _set_get_dragged
var _last_g_position := Vector2.ZERO
var _last_tray_position := Vector2.ZERO
var _is_mouse_focus := false : set = set_mouse_focus
var _spread_num := -1 
var _collition_shapes : Array[CollisionShape2D]
var _area_overlappingui := false
var _area_outside_spread := false
var _area_spreadview : SpreadView
var _area_stickertray := false

@export var _info : StickerResource: get = get_info

func _ready() -> void:
	set_z_index(50)
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER, true)
	set_collision_mask_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	_connect_children() 
	visible_on_screen_notifier_2d.screen_exited.connect(_screen_exited)
	await get_tree().process_frame
	_post_ready()

# if being carried by the hand, requeset the hand drop 
func _screen_exited() -> void:
	print("fell out of scren")
	request_drop.emit(self)
	#StickerTray.return_to_tray(self, true)

func _post_ready() -> void:
	_update_status_color()
	if !_info.match_object(self):
		_info = _info.duplicate()
		_info.set_object(self)

func _connect_children() -> void:
	for each_child in get_children():
		if each_child is CollisionShape2D:
			_collition_shapes.append(each_child)

func set_info(info: StickerResource, use_values: bool = false) -> void: 
	_info = info
	if use_values:
		position = _info._local_position
		rotation = _info._local_rotation

func get_info() -> StickerResource: return _info

func activate() -> void:
	show()
	for each in _collition_shapes:
		each.set_disabled(false)

func deactivate() -> void:
	hide()
	for each in _collition_shapes:
		each.set_disabled(true)

func set_spread(num: int) -> void: _spread_num = num

func match_spread(spraed: int) -> bool: return spraed == _spread_num

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
	_update_status_color()

func try_pickup() -> StickerEntity:  ## allows some stickers to be locked in place or have other rules
	_is_get_dragged = true
	_last_g_position = global_position
	return self

func release_pickup() -> void: 
	_is_get_dragged = false
	_update_status_color()
	if _area_overlappingui and !_area_stickertray:
		StickerTray.return_to_tray(self, true)
	if _area_spreadview:
		_area_spreadview.try_to_stick(self)

func _set_get_dragged(value: bool) -> void:
	if value == _is_get_dragged: 
		return
	_is_get_dragged = value
	if _is_get_dragged:
		picked_up.emit(self)
	_update_status_color()

func try_rotation(direction: float) -> void:
	rotation += (direction * TAU / 8.0)
	rotation = snappedf(rotation, TAU / 8.0)

func _update_status_color() -> void:
	var outline_color : Color
	if _area_overlappingui and !_area_stickertray:
		outline_color = Utilties.STICKER_OUTLINE_WARNING_UI
	else: 
		if _area_outside_spread and !_area_stickertray:
			outline_color = Utilties.STICKER_OUTLINE_WARNING
		elif _is_mouse_focus:
			outline_color = Color.WHITE
		else: 
			outline_color = Color.TRANSPARENT

		if _area_spreadview and !_area_outside_spread:
			sprite_shadow.show()
		else:
			sprite_shadow.hide()
	sprite_outline.set_modulate(outline_color)

func __on_area_changed(area: Node2D, is_entered := true) -> void:
	if area is OverlappingUI:
		_area_overlappingui = is_entered
	elif area is OutsideSpread:
		_area_outside_spread = is_entered
	elif area is SpreadView:
		if is_entered:
			_area_spreadview = area
		else:
			_area_spreadview = null
	elif area is StickerTray:
		_area_stickertray = is_entered
	else:
		push_warning(area, is_entered)
	_update_status_color() 

func _on_area_entered(area: Node2D) -> void: __on_area_changed(area, true)

func _on_area_exited(area: Node2D) -> void: __on_area_changed(area, false)

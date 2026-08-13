class_name MouseSticker extends Node2D

# instead of moving the sticker within the sticker, 
# move the sticker from the perspective of the mouse. 

# detect when over a sticker
# track the order of stickers

@onready var sticker_finder: Area2D = %StickerFinder

@export_category("GUIDE")
@export var _guide_context: GUIDEMappingContext
@export var _action_grab : GUIDEAction
@export var _action_release : GUIDEAction
@export var _action_rotate : GUIDEAction


var _overlapping_stickers :Array [Sticker]
var _held_sticker : Sticker
var _sticker_offset : Vector2

var _is_active := true

func _ready() -> void:
	sticker_finder.set_collision_mask_value(Utilties.COLLISION_LAYER.STICKER, true)
	if _guide_context:
		GUIDE.enable_mapping_context(_guide_context)
		if _action_grab:
			_action_grab.triggered.connect(_on_action_grab)
		if _action_release:
			_action_release.triggered.connect(_on_action_release)
		if _action_rotate:
			_action_rotate.triggered.connect(_on_action_rotate)

func _process(_delta: float) -> void:
	if !_is_active:
		return
	set_global_position(get_global_mouse_position())
	#prints(sticker_finder.get_overlapping_areas(), _overlapping_stickers, _held_sticker, _sticker_offset)
	if _held_sticker:
		_held_sticker.set_global_position(get_global_mouse_position() + _sticker_offset)

func _on_sticker_finder_area_entered(area: Area2D) -> void:
	if area is Sticker:
		if !_overlapping_stickers.has(area):
			var index := 0
			if _is_dragging() and _overlapping_stickers.size() >= 1:
				index = 1
			_overlapping_stickers.insert(index, area)
		_overlapping_stickeres_updated()

func _on_sticker_finder_area_exited(area: Area2D) -> void:
	if area is Sticker:
		area.set_mouse_focus(false)
		while _overlapping_stickers.has(area):
			_overlapping_stickers.erase(area)
		_overlapping_stickeres_updated()

func _overlapping_stickeres_updated() -> void:
	var index := 0
	for each in _overlapping_stickers:
		each.set_mouse_focus(index == 0)
		index += 1

func _is_dragging() -> bool: return _held_sticker != null

func _on_action_grab() -> void:
	if !_is_active:
		return
	if !_overlapping_stickers.is_empty():
		_held_sticker = _overlapping_stickers[0].try_pickup()
		if _held_sticker:
			_sticker_offset = _held_sticker.global_position - get_global_mouse_position()

func _on_action_release() -> void:
	if !_is_active:
		return
	if _held_sticker:
		if !_overlapping_stickers.is_empty(): 
			_overlapping_stickers.erase(_held_sticker)
			_overlapping_stickers.append(_held_sticker)
		_held_sticker.release_pickup()
		_held_sticker = null
		_sticker_offset = Vector2.ZERO

func _on_action_rotate() -> void:
	if !_is_active:
		return
	if _held_sticker:
		_held_sticker.try_rotation(_action_rotate.value_axis_1d)

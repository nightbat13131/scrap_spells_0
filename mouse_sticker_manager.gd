class_name MouseSticker extends Node2D

# instead of moving the sticker within the sticker, 
# move the sticker from the perspective of the mouse. 

# detect when over a sticker
# track the order of stickers
# 

@onready var sticker_finder: Area2D = %StickerFinder

@export_category("GUIDE")
@export var _guide_context: GUIDEMappingContext
@export var _action_grab : GUIDEAction
@export var _action_release : GUIDEAction
@export var _action_rotate : GUIDEAction


var _overlapping_stickers :Array [Sticker]
var _held_sticker : Sticker
var _sticker_offset : Vector2

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
	set_global_position(get_global_mouse_position())
	#prints(sticker_finder.get_overlapping_areas(), _overlapping_stickers, _held_sticker, _sticker_offset)
	if _held_sticker:
		_held_sticker.set_global_position(get_global_mouse_position() + _sticker_offset)

func _on_sticker_finder_area_entered(area: Area2D) -> void:
	if area is Sticker:
		if !_overlapping_stickers.has(area):
			_overlapping_stickers.append(area)

func _on_sticker_finder_area_exited(area: Area2D) -> void:
	if area is Sticker:
		while _overlapping_stickers.has(area):
			_overlapping_stickers.erase(area)

func _on_action_grab() -> void:
	if !_overlapping_stickers.is_empty():
		_held_sticker = _overlapping_stickers[0].try_pickup()
		if _held_sticker:
			_sticker_offset = _held_sticker.global_position - get_global_mouse_position()

func _on_action_release() -> void:
	if _held_sticker:
		if !_overlapping_stickers.is_empty(): 
			_overlapping_stickers.erase(_held_sticker)
			_overlapping_stickers.append(_held_sticker)
		_held_sticker.release_pickup()
		_held_sticker = null
		_sticker_offset = Vector2.ZERO

func _on_action_rotate() -> void:
	if _held_sticker:
		#print(_action_rotate.value_axis_1d)
		_held_sticker.try_rotation(_action_rotate.value_axis_1d)

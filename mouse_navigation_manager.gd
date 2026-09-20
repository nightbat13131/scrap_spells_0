class_name MouseApearance extends Node2D

@export var _inventory_button_group : ButtonGroupEnhanced

@onready var held_texture_rect: TextureRect = %HeldTextureRect
@onready var hand_sprite_2d: Sprite2D = %HandSprite2D

@export var hand_idle : Texture2D
@export var hand_holding_item : Texture2D
@export var hand_spell : Texture2D

var _active_usable : Usable
var _active_spell : StickerResource_Socket
var _is_holding_sticker : bool

static var _instance : MouseApearance

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if _inventory_button_group:
		_inventory_button_group.pressed.connect(_on_pressed)
	_instance = self

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_pressed( _button: BaseButton) -> void:
	var active : BaseButton = _inventory_button_group.get_pressed_button()
	if active:
		if active is ShowUsableButton:
			_set_active_usable(active.get_usable())
			_active_spell = null
		else:# spell place holder
			_set_active_usable(null)
			_active_spell = ScrapBookModel.get_active_spell()
	else: 
		_set_active_usable(null)
		_active_spell = null
	Camera3DEnhanced.spell_cast(_active_spell)
	_update_hand()

func _set_active_usable(thing: Usable)  -> void:
	if _active_usable:
		_active_usable.changed.emit()
	_active_usable = thing
	if _active_usable:
		held_texture_rect.set_texture(_active_usable.get_icon())
		_active_usable.changed.emit()
		
	else: 
		held_texture_rect.set_texture(null)
		hand_sprite_2d.set_texture(hand_idle)
	_update_hand() 

func _update_hand() -> void:
	if _active_usable or _is_holding_sticker:
		hand_sprite_2d.set_texture(hand_holding_item)
	elif _active_spell: 
		hand_sprite_2d.set_texture(hand_spell)
	else: 
		hand_sprite_2d.set_texture(hand_idle)

func _set_sticker_held(is_held: bool) -> void:
	_is_holding_sticker = is_held
	_update_hand()

static func sticker_held() -> void:
	if _instance:
		_instance._set_sticker_held(true)

static func sticker_released() -> void:
	if _instance:
		_instance._set_sticker_held(false)

static func get_active_spell() -> StickerResource_Socket:
	if _instance:
		return _instance._active_spell
	return null

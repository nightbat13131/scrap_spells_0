extends Node2D

@export var _inventory_button_group : ButtonGroup

@onready var held_texture_rect: TextureRect = %HeldTextureRect
@onready var hand_sprite_2d: Sprite2D = %HandSprite2D

@export var hand_idle : Texture2D
@export var hand_holding_item : Texture2D
@export var hand_spell : Texture2D

var _active_usable : Usable
var _active_spell : StickerResource
var _is_holding_sticker : bool

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if _inventory_button_group:
		_inventory_button_group.pressed.connect(_on_pressed)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_pressed( _button: BaseButton) -> void:
	#print("Group pressed", _button)
	var active : BaseButton = _inventory_button_group.get_pressed_button()
	if active:
		if active is ShowUsableButton:
			_set_active_usable(active.get_usable())
			_active_spell = null
		else:# spell place holder
			_set_active_usable(null)
			_active_spell = StickerResource.new()
	else: 
		_set_active_usable(null)
		_active_spell = null
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

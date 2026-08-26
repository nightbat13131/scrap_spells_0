extends Node2D

@export var _inventory_button_group : ButtonGroup

@onready var hand_texture_rect: TextureRect = %HandTextureRect


var _active_usable : Usable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _inventory_button_group:
		_inventory_button_group.pressed.connect(_on_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_pressed( _button: BaseButton) -> void:
	var active : BaseButton = _inventory_button_group.get_pressed_button()
	if active:
		if active is ShowUsable:
			_set_active_usable(active.get_usable())
	else:
		_set_active_usable(null)

func _set_active_usable(thing: Usable)  -> void:
	if _active_usable:
		_active_usable.changed.emit()
	_active_usable = thing
	if _active_usable:
		hand_texture_rect.set_texture(_active_usable.get_icon())
		_active_usable.changed.emit()
	else: 
		hand_texture_rect.set_texture(null)

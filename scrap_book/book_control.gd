class_name BookControl extends Control

@onready var flip_book_left: Button = %FlipBook_Left
@onready var flip_book_right: Button = %FlipBook_Right
@onready var inspect_book: Button = %InspectBook

@onready var left_spacer: Control = %LeftSpacer
@onready var cover_outside: TextureRect = %CoverOutside
@onready var cover_inside: TextureRect = %CoverInside
@onready var page_left: TextureRect = %PageLeft
@onready var page_right: TextureRect = %PageRight
@onready var back_inside: TextureRect = %BackInside
@onready var right_spacer: Control = %RightSpacer

@onready var _book_parts : Array[Control] = [cover_outside, cover_inside, page_left, page_right, back_inside]
@onready var _notification_texture: TextureRect = %Notification

@onready var book_button: Button = %BookButton

@export var _inventory_button_group: ButtonGroupEnhanced

var _model : ScrapBookModel


static var _instance : BookControl

func _ready() -> void:
	_instance = self
	_model = ScrapBookModel.get_model()
	_model.close_book.connect(_update_spread)
	_model.open_book.connect(_update_spread)
	_model.page_turn.connect(_update_spread)
	inspect_book.pressed.connect(BookUI.request_toggle)
	flip_book_left.pressed.connect(_on_turn_request.bind(Vector2i.LEFT))
	flip_book_right.pressed.connect(_on_turn_request.bind(Vector2i.RIGHT))
	_update_spread.call_deferred()
	_request_notification(false)
	_model.spell_updated.connect(_on_spell_update)

func _on_turn_request(direction: Vector2i) -> void:
	if _model:
		_model.turn_page(direction)
		if _inventory_button_group:
			_inventory_button_group.request_refresh()

func _update_spread() -> void:
	assert(_model)
	var _shows : Array[Control] = []
	var _spread: SpreadModel = _model.get_current_spread()
	if !_model.is_open():
		_shows = [cover_outside]
	else:
		if _spread: # first loads null
		
			if _spread.get_left_page():
				_shows.append(page_left)
			else:
				_shows.append(cover_inside)
			if _spread.get_right_page():
				_shows.append(page_right)
			else: 
				_shows.append(back_inside)
			
	for each in _book_parts:
		if _shows.has(each):
			each.show()
		else:
			each.hide()

static func request_notification(do_show: bool = true) -> void:
	if _instance:
		_instance._request_notification(do_show)

func _request_notification(do_show: bool) -> void:
	_notification_texture.set_visible(do_show)

func _on_spell_update() -> void:
	var spell : StickerResource = ScrapBookModel.get_active_spell()
	var color = Color.TRANSPARENT
	if spell:
		color = spell.get_gem_color() # Color(randf(), randf(), randf())
		book_button.set_button_icon(spell.book_ui_icon)
	else:
		if book_button.is_pressed:
			book_button.set_pressed(false)
		pass
	book_button.set_modulate(color)
	book_button.set_disabled(spell == null)
	

class_name BookContorl extends Control

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

## The power of the ButtonGroup sends the 
@onready var book_button: Button = %BookButton

@export var _model : ScrapBookModel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_model = ScrapBookModel.get_model()
	_model.close_book.connect(_update_spread)
	_model.open_book.connect(_update_spread)
	_model.page_turn.connect(_update_spread)
	inspect_book.pressed.connect(BookUI.request_toggle)
	flip_book_left.pressed.connect(_on_turn_request.bind(Vector2i.LEFT))
	flip_book_right.pressed.connect(_on_turn_request.bind(Vector2i.RIGHT))
	_update_spread()

func _on_turn_request(direction: Vector2i) -> void:
	if _model:
		_model.turn_page(direction)

func _update_spread() -> void:
	assert(_model)
	var _shows : Array[Control]
	if !_model.is_open():
		_shows = [cover_outside]
	else:
		_shows = [cover_inside, back_inside]
	for each in _book_parts:
		if _shows.has(each):
			each.show()
		else:
			each.hide()
	

class_name ScrapBookView extends Node2D

var _model : ScrapBookModel
var _last_spread : SpreadModel
var _next_spread : SpreadModel
var _is_open := true: set = _set_is_open

func is_animation_active() -> bool: return false

func set_spell_book_model (info: ScrapBookModel) -> void:
	_model = info
	_model.close_book.connect(_on_book_close)
	_model.open_book.connect(_on_book_open)
	_model.page_turn.connect(_on_page_turn)
	_is_open = _model.is_open()
	_last_spread = _model.get_current_spread()

func _set_is_open(value: bool) -> void: _is_open = value

func _on_book_open() -> void: 
	if !_is_open:
		_is_open = true
		print("open book")
		prints(_last_spread)

func _on_book_close() -> void: 
	if _is_open:
		_is_open = false
		print("close book")
		prints("[ ]")

func _on_page_turn() -> void:
	assert(_model)
	_next_spread = _model.get_current_spread()
	if _next_spread == _last_spread:
		return
	if _next_spread.get_page_sum() < _last_spread.get_page_sum():
		print("Going smaller left")
	else:
		print("Going larger right")
	prints(str(_last_spread), "->", str(_next_spread))
	_last_spread = _next_spread
	_next_spread = null

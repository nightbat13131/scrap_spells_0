class_name ScrapBookView extends Node2D


var _model : ScrapBookModel

var _last_left_page := -1
var _is_open := true

func set_spell_book_model (info: ScrapBookModel) -> void:
	_model = info
	_model.close_book.connect(_on_book_close)
	_model.open_book.connect(_on_book_open)
	_model.page_turn.connect(_on_page_turn)
	_is_open = _model.is_open()

func _on_book_open() -> void: 
	if !_is_open:
		_is_open = true
		print("open book")
		prints(_get_layout_string(_model.get_left_page()))

func _on_book_close() -> void: 
	if _is_open:
		_is_open = false
		print("close book")
		prints("[ ]")

func _on_page_turn() -> void:
	assert(_model)
	var _current_left : int = _model.get_left_page()
	if _current_left == _last_left_page:
		return
	if _current_left < _last_left_page:
		print("Going smaller left")
	else:
		print("Going larger right")
	prints(_get_layout_string(_last_left_page), "->", _get_layout_string(_current_left))
	_last_left_page = _current_left


func _get_layout_string(left: int) -> String:
	var out := "["
	var page: PageModel = _model.get_page(left)
	if page:
		out += str(page)
	else:
		out += "_"
	out += "|"
	page = _model.get_page(left+1)
	if page:
		out += str(page)
	else:
		out += "_"
	out += "]"
	return out

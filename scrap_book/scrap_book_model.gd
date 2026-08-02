class_name ScrapBookModel extends Resource

signal page_turn
signal open_book
signal close_book


var _spread_number := 0: set = _set_spread_num
var _is_open := true : set = _set_is_open, get = is_open
var _spreads : Array[SpreadModel]


func from_save(data: SaveResource0) -> void:
	if data == null:
		data = SaveResource0.new()
	var paper_count := data.get_paper_count()
	for index in range(paper_count +1 ):
		_spreads.append(data.get_spread_model(index))

func get_current_spread() -> SpreadModel: return _spreads[_spread_number]

func _set_spread_num(num: int) -> void:
	if !_is_open:
		_is_open = true
		return
	if num < 0 or num >= _spreads.size():
		_is_open = false
		return
	_spread_number = num
	page_turn.emit()

func turn_page(direction: Vector2i) -> void:
	var do := 1
	if direction == Vector2i.LEFT: do *= -1
	_spread_number += do

func is_open() -> bool: return _is_open

func request_open() -> void: _set_is_open(true)

func request_close() -> void: _set_is_open(false)

func _set_is_open(value: bool) -> void:
	if value == _is_open: return
	_is_open = value
	if _is_open:
		print("_book open")
		open_book.emit()
		print(get_current_spread())
	else:
		print("_book close")
		close_book.emit()

class_name ScrapBookModel extends Resource

signal page_turn
signal open_book
signal close_book

var _left_page := 0 : set =_set_left_page, get = get_left_page
var _is_open := true : set = _set_is_open, get = is_open

var _paper_count := -1
var _pages: Array[PageModel]

func from_save(data: SaveResource0) -> void:
	if data == null:
		data = SaveResource0.new()
	_paper_count = data.get_paper_count()
	var page_num := 0
	var page: PageModel
	while page_num < get_max_page():
		page_num += 1
		page = data.get_page_model(page_num)# PageModel.new()
		_pages.append(page)
		#page.setup(self, page_num)
		print(self, page)
	print(_pages.size())

func _set_left_page(page: int) -> void:
	if !_is_open:
		_is_open = true
		return
	if page < 0 or page > get_max_page():
		_is_open = false
		return
	page += page % 2
	page = clamp(page, 0, get_max_page())
	if page != _left_page:
		_left_page = page
		print(_left_page)
		page_turn.emit()

func turn_page(direction: Vector2i) -> void:
	var do := 2
	if direction == Vector2i.LEFT: do *= -1
	_left_page += do

func get_left_page() -> int: return _left_page

func get_page(page_num: int) -> PageModel:
	if page_num <= 0 or page_num > _pages.size():
		return null
	page_num -= 1
	return _pages.get(page_num)

func get_max_page() -> int: return _paper_count *2

func is_open() -> bool: return _is_open

func request_open() -> void: _set_is_open(true)

func request_close() -> void: _set_is_open(false)

func _set_is_open(value: bool) -> void:
	if value == _is_open: return
	_is_open = value
	if _is_open:
		print("_book open")
		open_book.emit()
		
	else:
		print("_book close")
		close_book.emit()

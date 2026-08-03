class_name SpreadModel  extends Resource

var _left_page : PageModel
var _right_page : PageModel
var _stickeres: Array[Sticker]

func set_pages(left: PageModel, right: PageModel) -> void:
	_left_page = left
	_right_page = right

func get_left_page() -> PageModel: return _left_page

func get_right_page() -> PageModel : return _right_page

func get_page_sum() -> int:
	var num := 0
	if _left_page:
		num += _left_page.get_page_number()
	if _right_page:
		num += _right_page.get_page_number()
	return num

func _to_string() -> String:
	var out := "["
	var page: PageModel = get_left_page()
	if page:
		out += str(page)
	else:
		out += "_"
	out += "|"
	page = get_right_page()
	if page:
		out += str(page)
	else:
		out += "_"
	out += "]"
	return out

func get_stickers() -> Array[Sticker]: return _stickeres

func get_spread_index() -> int:
	if get_left_page():
		@warning_ignore("integer_division")
		return get_left_page().get_page_number()/2
	return 0

func sync_stickers(list: Array[Sticker]) -> void: _stickeres = list

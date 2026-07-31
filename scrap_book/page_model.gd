class_name PageModel extends Resource

var _book_model: ScrapBookModel
var _page_number: int

func setup(info: ScrapBookModel, page_number: int) -> void:
	_book_model = info
	_page_number = page_number

func _to_string() -> String: return str(_page_number)

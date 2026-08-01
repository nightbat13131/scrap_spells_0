class_name PageModel extends Resource

#var _book_model: ScrapBookModel
var _page_number: int
var _text := """[color="black"]Page[/color]"""

#func set_scrapbook(info: ScrapBookModel) -> void: _book_model = info

func get_page_number() -> int: return _page_number

func set_page_number(page_number: int) -> void: _page_number = page_number

func _to_string() -> String: return str(_page_number)

func set_page_text(text: String) -> void: _text = text

func get_page_text() -> String: return _text

class_name SpreadModel  extends Resource

var _left_page : PageModel
var _right_page : PageModel
var _stickeres: Array[StickerResource]

func get_left_page() -> PageModel: return _left_page

func get_right_page() -> PageModel : return _right_page

## used for checking direction of page turn
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

func get_stickers() -> Array[Sticker]: 
	var out : Array[Sticker]
	var holder: Sticker
	for each in _stickeres:
		if each:
			holder = each.get_sticker(true)
			if holder:
				out.append(holder)
	return out

func get_spread_index() -> int:
	if get_left_page():
		@warning_ignore("integer_division")
		return get_left_page().get_page_number()/2
	return 0

# used by save and view/controler
func set_stickers(list: Array[Sticker]) -> void: 
	_stickeres = []
	for each in list:
		if each:
			_stickeres.append(each.get_info())

#region save/load

func set_pages(left: PageModel, right: PageModel) -> void:
	_left_page = left
	_right_page = right

#func _update_save() -> void:
	#var data := SaveResource.get_save()
	#data.set_scrapbook_spread(get_spread_index(), self)

func to_save_dict() -> Dictionary:
	var out : Dictionary
	out[SaveResource.STICKERS] = []
	var list : Array[Dictionary]
	for each in out.get(SaveResource.STICKERS):
		list.append(each)
		
	for each in _stickeres:
		if each:
			list.append(each.get_dict())
	return out

#endregion

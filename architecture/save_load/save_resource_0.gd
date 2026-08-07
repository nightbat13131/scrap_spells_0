class_name SaveResource0 extends SaveResource

func update_save_game_state() -> SaveResource: 
	StickerTray.request_save()
	return self

func _get_page_model(page_number: int) -> PageModel:
	if page_number < 1 or page_number > _get_spread_count() * 2:
		return null
	var page := PageModel.new()
	page.set_page_number(page_number)
	if page_number == 1:
		page.set_page_text(Utilties.FIRST_PAGE_TEXT)
	else: 
		page.set_page_text("""[color="blue"]Page[/color]""")
	return page

func get_scrapbook_model() -> ScrapBookModel: 
	var book = ScrapBookModel.get_model()
	var spreads : Array[SpreadModel]
	for spread_index in range(_get_spread_count()):
		spreads.append(_get_spread_model(spread_index))
	book.set_spreads(spreads)
	return book

func _get_spread_model(spread_index: int) -> SpreadModel:
	var dict : Dictionary
	var list_a : Array
	if !_loaded_json.has(SCRAPBOOK):
		_loaded_json[SCRAPBOOK] = {}
	dict = _loaded_json[SCRAPBOOK]
	if !dict.has(SCRAPBOOK_SPREADS) :
		dict[SCRAPBOOK_SPREADS] = []
	list_a = dict[SCRAPBOOK_SPREADS]
	if spread_index >= list_a.size():
		dict = {}
	else: 
		dict = list_a[spread_index]
	var sticker_dicts : Array[Dictionary]
	for each: Dictionary in dict.get(STICKERS, []):
		if each:
			sticker_dicts.append(each)
	var spread = SpreadModel.new()
	var pages : Array[PageModel] = [ _get_page_model(spread_index*2), _get_page_model(spread_index*2+1)]
	spread.set_pages(pages[0], pages[1])
	spread.set_stickers(_stickers_from_list_sticker_dicts(sticker_dicts))
	return spread 

func set_scrapbook_spread(spread_index : int, spread_model: SpreadModel) -> void:
	var dict : Dictionary
	var list_a : Array
	if !_loaded_json.has(SCRAPBOOK):
		_loaded_json[SCRAPBOOK] = {}
	dict = _loaded_json[SCRAPBOOK]
	if !dict.has(SCRAPBOOK_SPREADS) :
		dict[SCRAPBOOK_SPREADS] = []
	list_a = dict[SCRAPBOOK_SPREADS]
	while spread_index >= list_a.size():
		list_a.append({})
	list_a[spread_index] = spread_model.to_save_dict()

func get_tray_stickers() -> Array[Sticker]:
	if !_loaded_json.has(STICKER_TRAY):
		var a: Array[Sticker] = []
		return a
	var b : Array[Dictionary] = []
	for each : Dictionary in _loaded_json[STICKER_TRAY].get(STICKERS):
		b.append(each)
	return _stickers_from_list_sticker_dicts(b)

func _stickers_from_list_sticker_dicts(list: Array[Dictionary]) -> Array[Sticker]:
	if list.is_empty():
		return []
	var out : Array[Sticker] = []
	var sticker_info : StickerResource
	var sticker : Sticker
	var _position : Vector2
	var _rotation : float
	if !_loaded_json.has(STICKER_TRAY):
		return []
	for sticker_dict in list:
		sticker_info = StickerManager_AL.get_sticker_info(sticker_dict.get(STICKER_ID, Utilties.StickerID.NA) )
		if sticker_info:
			sticker_info = sticker_info.duplicate()
			_position = JSON.to_native(sticker_dict.get(LOCAL_POSITION, {"args":[40.0,40.0],"type":"Vector2"}) )
			_rotation = sticker_dict.get(LOCAL_ROTATION, 1.0)
			sticker_info.set_saved_values(_position, _rotation)
			sticker = sticker_info.get_sticker(true)
		if sticker:
			out.append(sticker)

	return out

func set_sticker_tray_stickers(info: Array[StickerResource]) -> void: 
	if !_loaded_json.has(STICKER_TRAY):
		_loaded_json[STICKER_TRAY] = {}
	_loaded_json[STICKER_TRAY][STICKERS] = [] ## empty list as it's being refreshed from the info
	for each in info:
		_loaded_json[STICKER_TRAY][STICKERS].append(each.get_dict())
	

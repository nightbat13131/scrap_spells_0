class_name SaveResource0 extends SaveResource

func save_game_state() -> SaveResource: 
	StickerTray.request_save(self)
	return self

func _get_page_model(page_number: int) -> PageModel:
	if page_number < 1 or page_number > get_paper_count() * 2:
		return null
	var page := PageModel.new()
	page.set_page_number(page_number)
	if page_number == 1:
		page.set_page_text(Utilties.FIRST_PAGE_TEXT)
	else: 
		page.set_page_text("""[color="blue"]Page[/color]""")
	return page

func get_spread_model(spread_index: int) -> SpreadModel:
	var spread = SpreadModel.new()
	var pages : Array[PageModel] = [ _get_page_model(spread_index*2), _get_page_model(spread_index*2+1)]
	spread.set_pages(pages[0], pages[1])
	return spread 

func get_tray_stickers() -> Array[Sticker]:
	var out : Array[Sticker] = []
	var sticker_info : StickerResource
	#var _sticker_id := Utilties.StickerID.GODOT
	var sticker : Sticker
	var _position : Vector2
	var _rotation : float
	if !_loaded_json.has(STICKER_TRAY):
		return []
	for sticker_dict in _loaded_json[STICKER_TRAY].get(STICKERS, []):
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
	

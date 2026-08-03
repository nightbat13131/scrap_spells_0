class_name SaveResource0 extends SaveResource


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
	var sticker_id := Utilties.StickerID.GODOT
	var sticker_info : StickerResource
	var sticker : Sticker

	for index in range(3):
		sticker_info = StickerManager_AL.get_sticker_info(sticker_id).duplicate()
		sticker_info.set_saved_values(Vector2.ONE * 20 * index, index)
		sticker = StickerManager_AL.request_sticker(sticker_id)
		sticker.set_info(sticker_info, true)
		if sticker:
			out.append(sticker)

	return out
	

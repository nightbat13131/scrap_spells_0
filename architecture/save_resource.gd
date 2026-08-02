class_name SaveResource0 extends Resource



func get_paper_count() -> int: return 3

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

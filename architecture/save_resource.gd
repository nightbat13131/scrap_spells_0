class_name SaveResource0 extends Resource


func get_paper_count() -> int: return 3

func get_page_model(page_number: int) -> PageModel:
	var page := PageModel.new()
	page.set_page_number(page_number)
	if page_number == 1:
		page.set_page_text(Utilties.FIRST_PAGE_TEXT)
	else: 
		page.set_page_text("""[color="blue"]Page[/color]""")
	return page

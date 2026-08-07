class_name FileManager extends FileAccess



static func save_to_file(save_progress: SaveResource):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(save_progress.get_save_string())

static func load_from_file() -> SaveResource:
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_as_text()
	var out = SaveResource.get_save() #  SaveResource0.new()
	out.set_loaded_string(content)
	return out

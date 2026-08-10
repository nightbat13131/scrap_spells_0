class_name FileManager extends FileAccess

const SAVE_PATH := "user://save_game.dat"

static func save_to_file(save_progress: SaveResource):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(save_progress.get_save_string())

static func load_from_file() -> SaveResource:
	var content : String = '{}'
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		content = file.get_as_text()
	var out = SaveResource.get_save() #  SaveResource0.new()
	out.set_loaded_string(content)
	return out

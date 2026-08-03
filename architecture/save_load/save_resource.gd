class_name SaveResource extends Resource

const SAVE_VERSION = &"save_version"
const SECTION_SETTINGS = &"settings_section"
const SECTION_GAME = &"game_section"
const STICKER_TRAY = &"sticker_tray"
const STICKERS = &"stickers"
const SCRAPBOOK = &"scrapbook"
const SCRAPBOOK_SPREADS = &"book_spreads"
const SCRAPBOOK_PAGES = &"book_pages"
const NULL = &"null"
const LOCAL_POSITION = &"local_position_x"
const LOCAL_ROTATION = &"local_rotation"
const STICKER_ID = &"sticker_id"

var _loaded_string : String = ''
var _loaded_json : Dictionary

func set_loaded_string(string: String) -> void: 
	_loaded_string = string
	_loaded_json = JSON.parse_string(_loaded_string)
	_loaded_json[SECTION_GAME] = 2

#func _init() -> void:
	#var json := JSON.new()
	#json = JSON.parse_string(default_text)
	#print(  )
	##json = JSON.parse_string("{}")
	#print("a")

func get_save_string() -> String:
	return JSON.stringify(_loaded_json)

var default_text = """
{ "save_version" : 1
}
"""

"""
	 "sticker_tray" : {
	"stickers" : [
		{"sticker_id" : -1, 
		"local_position_x": 56.5,
		"local_position_y": -65.0
		"local_rotation" : 0.0},
		
		{"sticker_id" : -1, 
		"local_position_x": -56.5,
		"local_position_y": 65.0
		"local_rotation" : 1.0}
	]
	}
}
"""

func get_tray_stickers() -> Array[Sticker]: return []

func get_spread_model(_spread_index: int) -> SpreadModel: return null

func get_paper_count() -> int: return 3

func _get_page_model(_page_number: int) -> PageModel: return null

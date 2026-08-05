class_name SaveResource extends Resource

const NULL = &"null"

const SAVE_VERSION = &"save_version"
const SAVE_SLOT = &"save_slot"
#const SECTION_SETTINGS = &"settings_section"
#const SECTION_GAME = &"game_section"
const 	STICKER_TRAY = &"sticker_tray"
			#STICKERS
const SCRAPBOOK = &"scrapbook"
const 	SCRAPBOOK_SPREADS = &"book_spreads"
const 	SCRAPBOOK_PAGES = &"book_pages"
			#STICKERS

const STICKERS = &"stickers"
const STICKER_ID = &"sticker_id"
const LOCAL_POSITION = &"local_position_x"
const LOCAL_ROTATION = &"local_rotation"


var _active_save_slot := 1

var _loaded_json : Dictionary

func save_game_state() -> SaveResource: return self

# called by file manager to populate resource 
func set_loaded_string(string: String) -> void: 
	#_loaded_string = string
	if string:
		_loaded_json = JSON.parse_string(string)
	else:
		_loaded_json = {}

func get_save_string() -> String: return JSON.stringify(_loaded_json)

func get_tray_stickers() -> Array[Sticker]: return []

func set_tray_stickers(_info: Array[StickerResource]) -> void: pass

func get_spread_model(_spread_index: int) -> SpreadModel: return null

func get_paper_count() -> int: return 3

func _get_page_model(_page_number: int) -> PageModel: return null




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

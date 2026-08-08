@abstract class_name SaveResource extends Resource

const NULL = &"null"

const SAVE_VERSION = &"save_version"
#const SAVE_SLOT = &"save_slot"
#const SECTION_SETTINGS = &"settings_section"
#const SECTION_GAME = &"game_section"
const 	STICKER_TRAY = &"sticker_tray"
			#STICKERS
const SCRAPBOOK = &"scrapbook"
const 	SCRAPBOOK_SPREADS = &"book_spreads"
const 		SCRAPBOOK_PAGE_LEFT = &"spread_page_left"
const 		SCRAPBOOK_PAGE_RIGHT = &"spread_page_right"
			#STICKERS

const STICKERS = &"stickers"
const STICKER_ID = &"sticker_id"
const LOCAL_POSITION = &"local_position_x"
const LOCAL_ROTATION = &"local_rotation"

#var _active_save_slot := 1

var _loaded_json : Dictionary

static var _instance : SaveResource

func _init() -> void: 
	if _instance:
		push_warning("SaveResource already exists")
	_instance = self

static func get_save() -> SaveResource:
	if _instance:
		return _instance
	return SaveResource0.new()

@abstract func update_save_game_state() -> SaveResource

# called by file manager to populate resource 
func set_loaded_string(string: String) -> void: 
	if string:
		_loaded_json = JSON.parse_string(string)
	else:
		_loaded_json = {}

func get_save_string() -> String: return JSON.stringify(_loaded_json)

@abstract func _stickers_from_list_sticker_dicts(list: Array[Dictionary]) -> Array[Sticker]

#region StickerTray

@abstract func get_tray_stickers() -> Array[Sticker]

@abstract func set_sticker_tray_stickers(_info: Array[StickerResource]) -> void

func _get_spread_count() -> int: return 5  #front, back, 3 full



#endregion

#region Scrapbook

@abstract func set_scrapbook_model(scrapbook: ScrapBookModel) -> void

@abstract func get_scrapbook_model() -> ScrapBookModel

@abstract func _get_spread_model(_spread_index: int) -> SpreadModel

@abstract func _get_page_model(page_number: int) -> PageModel

#@abstract func set_scrapbook_spread(spread_index : int, spread_model) -> void

#endregion







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

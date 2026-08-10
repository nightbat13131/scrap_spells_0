class_name Utilties extends RefCounted
## Banished to a wizard's tower with no one to save me but myself

enum StickerID {NA = 0,  GODOT = -1 , 
	TAPE_0 = 1, 
	KEY_0 = 10,
}

static var StickerUID : Dictionary[StickerID, String ] = {
# Remember to add resoruce to the StickerManager autoload
		StickerID.GODOT : "uid://dp3yhwlavt14t", 
		StickerID.TAPE_0: "uid://m6tw46tv8s1i",
		StickerID.KEY_0: "uid://cdwq4dms4b3nm"
		
	}

enum Socket_Gem { SOCKET_0 = -1 , NA = 0, GEM_BOT = 1}

enum COLLISION_LAYER { STICKER = 5, STICKER_PAPER = 6}


const PAGE_SIZE := Vector2(280,280)
const PAGE_SPINE := 25

const STICKER_OUTLINE_TRAY = Color.DIM_GRAY
const STICKER_OUTLINE_WARNING = Color.RED
const STICKER_OUTLINE_BOOK = Color.WHITE

const FIRST_PAGE_TEXT = """[color="black"]I don't want a journal as some "parting gift" I want TO BE [b]HOME[/b][/color]
[hr color="black" height=4]
[hr color="black"]
[hr color="black"]"""

const COVER_TEXT = """C\n O\n  V\n   E\n    R"""

const BACK_TEST = """Know that I'll miss you more than you can know\n        -M"""

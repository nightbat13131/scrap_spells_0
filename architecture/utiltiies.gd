class_name Utilties extends RefCounted
## Banished to a wizard's tower with no one to save me but myself

enum StickerID {NA = 0,  GODOT = -1 }

static var StickerUID : Dictionary[StickerID, String ] = {
		StickerID.GODOT : "uid://dp3yhwlavt14t", 
	}

const PAGE_SIZE := Vector2(280,280)
const PAGE_SPINE := 25

const STICKER_OUTLINE_TRAY = Color.DIM_GRAY
const STICKER_OUTLINE_WARNING = Color.RED
const STICKER_OUTLINE_BOOK = Color.WHITE

const FIRST_PAGE_TEXT = """[color="black"]I don't want a journal as some "parting gift" I want TO BE [b]HOME[/b][/color]
[hr color="black" height=4]
[hr color="black"]
[hr color="black"]"""

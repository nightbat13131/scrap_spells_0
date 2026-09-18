class_name Spell extends Resource

signal request_preview
signal request_missfire
signal request_cast
signal cast_complete

@export var socket : StickerResource_Socket
@export var gem : StickerResource_Gem

func is_equipted() -> bool: 
	var _equiped : StickerResource_Socket = MouseApearance.get_active_spell()
	if _equiped:
		return _equiped.match_spell(socket.sticker_ID, gem.sticker_ID)
	return false

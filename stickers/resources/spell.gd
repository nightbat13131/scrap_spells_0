class_name Spell extends Resource

#signal request_preview
#signal request_missfire
signal request_cast
signal cast_complete

@export var socket : StickerResource_Socket
@export var gem : StickerResource_Gem

func is_equipted() -> bool: 
	var _equiped : StickerResource_Socket = MouseApearance.get_active_spell()
	if _equiped:
		return _equiped.match_spell(self)# socket.sticker_ID, gem.sticker_ID)
	return false

func cast() -> void:
	request_cast.emit()
	MouseApearance.reqeuset_spell_drop(self)

func casting_complete() -> void: cast_complete.emit()

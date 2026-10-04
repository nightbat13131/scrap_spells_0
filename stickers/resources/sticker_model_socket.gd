class_name StickerResource_Socket extends StickerResource

var _socketed_gem: StickerResource_Gem



func get_gem_color() -> Color:
	if is_spell():
		return get_gem_info().get_gem_color()
	return super.get_gem_color()

func is_spell() -> bool: return _socketed_gem != null

func match_spell(spell: Spell): # socket_id: Utilties.StickerID, gem_id: Utilties.StickerID) -> bool:
	if self == spell.socket:
		if _socketed_gem:
			return _socketed_gem == spell.socket
	return false

func try_insert_gem(gem: StickerResource_Gem) -> bool:
	if gem == null:
		if _socketed_gem:
			_socketed_gem.set_socket(null)
	else: 
		gem.set_socket(self)
	_socketed_gem = gem
	gem_changed.emit()
	return true

func get_gem_info() -> StickerResource: return _socketed_gem

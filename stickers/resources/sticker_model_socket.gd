class_name StickerResource_Socket extends StickerResource

var _socketed_gem: StickerResource_Gem



func get_gem_color() -> Color:
	if is_spell():
		return get_gem_info().get_gem_color()
	return super.get_gem_color()

func is_spell() -> bool: return _socketed_gem != null

func match_spell(socket_id: Utilties.StickerID, gem_id: Utilties.StickerID) -> bool:
	if match_id(socket_id):
		if _socketed_gem:
			return _socketed_gem.match_id(gem_id)
	return false

func try_insert_gem(gem: StickerResource_Gem) -> bool:
	_socketed_gem = gem
	gem_changed.emit()
	return true

func get_gem_info() -> StickerResource: return _socketed_gem

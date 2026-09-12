class_name StickerResource extends Resource

signal gem_changed

@export var sticker_ID : Utilties.StickerID
@export_category("Gem/Socket")
#@export var socket_v_gem := Utilties.Socket_Gem.NA
@export var gem_color := Color.AQUA

@export var _socketed_gem: StickerResource

#Save: remember position
var _local_position : Vector2
#Save: remember rotation
var _local_rotation : float
#save: rememver z
#var _z_index: int

var _object : StickerEntity

func match_id(id: int) -> bool: return sticker_ID == id

func get_dict() -> Dictionary:
	var out : Dictionary = {}
	out[SaveResource.STICKER_ID] = sticker_ID
	if _object:
		out[SaveResource.LOCAL_POSITION] = JSON.from_native(_object.position)
		out[SaveResource.LOCAL_ROTATION] = _object.rotation
	print(out)
	return out

func set_saved_values(pos: Vector2, rotation: float) -> void:
	_local_position = pos
	_local_rotation = rotation

func get_sticker(load_with_save_values := true) -> StickerEntity:
	if _object == null:
		_object = StickerManager_AL.request_sticker(sticker_ID)
		_object.set_info(self, load_with_save_values)
	return _object

func match_object(sticker: StickerEntity) -> bool: return _object == sticker

func set_object(sticker: StickerEntity) -> void:
	if _object == sticker:
		print("STicker already set matching")
	elif _object != null:
		print("STicker already something else")
	else:
		_object = sticker


#region Is_SOCKET

func is_socket() -> bool:
	return [
		Utilties.StickerID.KEY_0, Utilties.StickerID.HAND_0, Utilties.StickerID.BODY_0
	].has(sticker_ID)

func is_spell() -> bool:
	if is_socket():
		return _socketed_gem != null
	return false

func match_spell(socket_id: Utilties.StickerID, gem_id: Utilties.StickerID) -> bool:
	if is_socket():
		if match_id(socket_id):
			if _socketed_gem:
				return _socketed_gem.match_id(gem_id)
	return false

func try_insert_gem(gem: StickerResource) -> bool:
	if !is_socket():
		return false
	if gem:
		if !gem.is_gem():
			return false
	_socketed_gem = gem
	gem_changed.emit()
	return true

func get_gem_info() -> StickerResource: 
	if is_socket():
		return _socketed_gem
	return null

#endregion

#region IS_GEM

func is_gem() -> bool:
	return [
		Utilties.StickerID.GODOT, Utilties.StickerID.SUN_0
	].has(sticker_ID)




#endregion

func be_looted() -> void:print("sticker looted")

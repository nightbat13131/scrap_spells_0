class_name StickerResource extends Resource

@export var sticker_ID : Utilties.StickerID
@export var socket_v_gem := Utilties.Socket_Gem.NA

#Save: remember position
var _local_position : Vector2
#Save: remember rotation
var _local_rotation : float
#save: rememver z
#var _z_index: int


func match_id(id: int) -> bool: return sticker_ID == id

var _object : Sticker

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

func get_sticker(load_with_save_values := true) -> Sticker:
	if _object == null:
		_object = StickerManager_AL.request_sticker(sticker_ID)
		_object.set_info(self, load_with_save_values)
	return _object

func match_object(sticker: Sticker) -> bool: return _object == sticker

func set_object(sticker: Sticker) -> void:
	if _object == sticker:
		print("STicker already set matching")
	elif _object != null:
		print("STicker already something else")
	else:
		_object = sticker

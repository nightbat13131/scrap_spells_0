class_name StickerResource extends Resource

@export var sticker_ID : Utilties.StickerID

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

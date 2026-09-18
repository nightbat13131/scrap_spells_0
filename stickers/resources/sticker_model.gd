class_name StickerResource extends Resource

signal gem_changed

@export var sticker_ID : Utilties.StickerID
@export_category("Gem/Socket")
#@export var socket_v_gem := Utilties.Socket_Gem.NA


## icon for book to show when it has a spell
@export var book_ui_icon : Texture2D

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

func get_gem_color() -> Color: return Color.TRANSPARENT

func be_looted() -> void:
	StickerTray.return_to_tray(StickerManager_AL.request_sticker(sticker_ID))
	BookControl.request_notification(true)

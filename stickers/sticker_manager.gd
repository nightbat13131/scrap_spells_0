class_name StickerManager extends Node
# Auto load to ensure classes can request the resources they need

@export var sticker_resources: Array[StickerResource]

func get_sticker_info(stickerid: Utilties.StickerID) -> StickerResource:
	for each : StickerResource in sticker_resources:
		if each.match_id(stickerid):
			return each
	return null

func request_sticker(stickerid: Utilties.StickerID) -> Sticker:
	var path : String = Utilties.StickerUID.get(stickerid)
	if path: 
		var packed_scene : PackedScene = load(path)
		if packed_scene.can_instantiate():
			return packed_scene.instantiate()
	return null

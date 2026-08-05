extends Node

var a : SaveResource

func _ready() -> void:
	%Debug2.pressed.connect(_on_debug_2)
	%Debug3.pressed.connect(_on_debug_3)


func _on_debug_2() -> void:
	if !a:
		a = FileManager.load_from_file()
	StickerTray.request_load(a)

func _on_debug_3() -> void:
	if !a:
		a = SaveResource.get_save()
	a.save_game_state()
	FileManager.save_to_file(a)
	

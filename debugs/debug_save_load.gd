extends Node

var a : SaveResource

func _init() -> void:
	a = SaveResource.get_save()
	FileManager.load_from_file()

func _ready() -> void:
	#a = SaveResource.get_save()
	#FileManager.load_from_file()
	%Debug2.pressed.connect(_on_debug_2)
	%Debug3.pressed.connect(_on_debug_3)

func _on_debug_2() -> void:
	if !a:
		a = FileManager.load_from_file()
	StickerTray.request_load()

func _on_debug_3() -> void:
	if !a:
		a = SaveResource.get_save()
	a.save_game_state()
	FileManager.save_to_file(a)
	

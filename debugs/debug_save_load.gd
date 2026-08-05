extends Node

var a : SaveResource

func _ready() -> void:
	%Debug2.pressed.connect(_on_debug_2)
	#FileManager.save_to_file(SaveResource0.new())
	await get_tree().create_timer(.5).timeout
	a = FileManager.load_from_file()
	a.save_game_state()
	print(a)
	
	FileManager.save_to_file(a)

func _on_debug_2() -> void:
	StickerTray.request_load(a)

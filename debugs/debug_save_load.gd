extends Node

func _ready() -> void:
	#FileManager.save_to_file(SaveResource0.new())
	var a := FileManager.load_from_file()
	print(a)
	FileManager.save_to_file(a)

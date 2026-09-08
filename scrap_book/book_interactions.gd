@tool
class_name BookInteractions extends Node2D


func _ready() -> void:
	_alone_test.call_deferred()


func _alone_test() -> void:
	print(get_parent())
	if get_parent() == get_tree().get_root(): # being called out of scene, need to move
		print("AAA")
		position = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height") ) * .5

func _draw() -> void:
	# display/window/size/viewport_width
	# display/window/size/viewport_height
	var _window_size := Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height") )
	_window_size.x -= 200 # left inventory 
	_window_size -= Vector2.ONE * 40 # ui padding
	var _nwcorner := _window_size * -.5
	draw_rect(
		Rect2(_nwcorner, _window_size)
		, Color.RED, false, 5
	)
	_window_size *= .33
	_nwcorner += _window_size
	for each in [Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT, Vector2.UP]:
		#each *= .5
		draw_rect(
			Rect2(_nwcorner + (_window_size * each) , _window_size)
			, Color.BLUE, false, 2
		)

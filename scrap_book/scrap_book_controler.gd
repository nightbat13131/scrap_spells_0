class_name ScrapBookControler extends Node

var _model: ScrapBookModel
@export var _view : ScrapBookView
@export_category("Controls")
@export var _left_button : Button
@export var _right_button : Button
@export var _toggle_open: Button

func _ready() -> void:
	_model = SaveResource.get_save().get_scrapbook_model() # ScrapBookModel.get_model()
	if _view:
		_view.set_spell_book_model.call_deferred(_model)
	connect_buttons()
	%SaveDebug.pressed.connect(request_save)

func _input_blocked() -> bool:
	if _model:
		if _view:
			return _view.is_animation_active()
		return false
	return true

func connect_buttons() -> void:
	if _toggle_open:
		_toggle_open.pressed.connect(_on_toggle_open)
	if _left_button:
		_left_button.pressed.connect(_on_turn_page.bind(Vector2i.LEFT))
	if _right_button:
		_right_button.pressed.connect(_on_turn_page.bind(Vector2i.RIGHT))

func _on_turn_page(direction: Vector2i) -> void:
	if _input_blocked(): return

	_model.turn_page(direction)

func _on_toggle_open() -> void:
	if _input_blocked(): return

	if _model.is_open():
		_model.request_close()
	else:
		_model.request_open()

func request_save() -> void:
	var data := SaveResource.get_save()
	data.set_scrapbook_model(_model)

class_name ScrapBookView_1 extends ScrapBookView

const TWEEN_DURATION = .5

@onready var sprite_open: Sprite2D = %Open
@onready var sprite_cover: Sprite2D = %Cover
@onready var sprite_page_left: Area2D = %Page_Left
@onready var sprite_page_right: Area2D = %Page_Right
@onready var page_num_left: Label = %PageNum_Left
@onready var page_num_right: Label = %PageNum_Right
@onready var page_text_left: RichTextLabel = %PageText_Left
@onready var page_text_right: RichTextLabel = %PageText_Right


func _ready() -> void:
	_on_page_turn.call_deferred()

var _animation_timer : SceneTreeTimer

func is_animation_active() -> bool: 
	if _animation_timer:
		return _animation_timer.time_left > 0.0
	return false

func _on_page_turn() -> void:
	super._on_page_turn()
	_update_page_view()

func _set_is_open(value: bool) -> void: 
	super._set_is_open(value)
	sprite_open.set_visible(_is_open)
	sprite_cover.set_visible(!_is_open)
	_animation_timer = get_tree().create_timer(TWEEN_DURATION)
	_update_page_view()

func _update_page_view() -> void:
	var page := _model.get_page(_last_left_page)
	if page == null:
		sprite_page_left.hide()
	else:
		sprite_page_left.show()
		page_num_left.set_text(str(page.get_page_number()))
		page_text_left.set_text(page.get_page_text())
	page = _model.get_page(_last_left_page +1)
	if page == null:
		sprite_page_right.hide()
	else:
		sprite_page_right.show()
		page_num_right.set_text(str(page.get_page_number()))
		page_text_right.set_text(page.get_page_text())

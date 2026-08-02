class_name ScrapBookView_1 extends ScrapBookView

const TWEEN_DURATION = .5

@onready var sprite_open: Sprite2D = %Open
@onready var sprite_cover: Sprite2D = %Cover
@onready var spread_view: SpreadView = %SpreadView



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
	spread_view.apply_spread(_last_spread)
	pass

class_name SpreadView extends Area2D

@onready var pages_collision: CollisionShape2D = %PagesCollision


@onready var page_left: Page = %Page_Left
@onready var page_right: Page = %Page_Right

var _spread: SpreadModel

func apply_spread(spread: SpreadModel) -> void:
	_spread = spread
	pages_collision.set_disabled(_spread == null)
	if spread:
		show()
		page_left.apply_page(_spread.get_left_page())
		page_right.apply_page(_spread.get_right_page())
	else:
		hide()

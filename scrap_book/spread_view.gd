class_name SpreadView extends Area2D

@onready var pages_collision: CollisionShape2D = %PagesCollision
@onready var boundry_right: CollisionShape2D = %Boundry_Right
@onready var boundry_left: CollisionShape2D = %Boundry_Left


@onready var page_left: Page = %Page_Left
@onready var page_right: Page = %Page_Right

var _spread: SpreadModel

func apply_spread(spread: SpreadModel) -> void:
	_spread = spread
	_setup_collition_shape()
	if spread:
		show()
		page_left.apply_page(_spread.get_left_page())
		page_right.apply_page(_spread.get_right_page())
	else:
		hide()
	for each_child in get_children():
		if each_child is Sticker:
			if each_child.is_fully_on_spread():
				each_child.activate_if_spread(_spread.get_spread_index())
			
				

func try_to_stick(sticker: Sticker) -> void:
	sticker.add_to_spread(_spread.get_spread_index())
	sticker.reparent(self, true)

func _setup_collition_shape() -> void:
	pages_collision.set_disabled(_spread == null)
	if !_spread:
		return
	var has_left := _spread.get_left_page() != null
	var had_right := _spread.get_right_page() != null
	if has_left and had_right:
		pages_collision.get_shape().size.x = Utilties.PAGE_SIZE.x * 2
		pages_collision.position.x = 0
		boundry_left.position.x = Utilties.PAGE_SIZE.x * -1
		boundry_right.position.x = Utilties.PAGE_SIZE.x
	else:
		pages_collision.get_shape().size.x = Utilties.PAGE_SIZE.x
		pages_collision.position.x = Utilties.PAGE_SIZE.x / 2
		if has_left:
			pages_collision.position.x *= -1
			boundry_left.position.x = Utilties.PAGE_SIZE.x * -1
			boundry_right.position.x = 0
		else:
			boundry_left.position.x = 0
			boundry_right.position.x = Utilties.PAGE_SIZE.x
	

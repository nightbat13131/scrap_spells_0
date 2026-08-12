class_name SpreadView extends Area2D

@onready var pages_collision: CollisionShape2D = %PagesCollision
@onready var boundry_right: CollisionShape2D = %Boundry_Right
@onready var boundry_left: CollisionShape2D = %Boundry_Left
@onready var area_void: OutsideSpread = %AreaVoid

@onready var page_left: Page = %Page_Left
@onready var page_right: Page = %Page_Right

var _spread: SpreadModel

func _init() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)

func _ready() -> void:
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)

func apply_spread(spread: SpreadModel) -> void:
	_before_spread_change() 
	_spread = spread
	_setup_collition_shape()
	if spread:
		show()
		page_left.apply_page(_spread.get_left_page())
		page_right.apply_page(_spread.get_right_page())
		var needed_stickers := spread.get_stickers().duplicate()
		for each_child in get_children():
			## useful when turning pages
			if each_child is Sticker:
				if needed_stickers.has(each_child):
					needed_stickers.erase(each_child)
					each_child.activate()
				else:
					each_child.deactivate()
		if !needed_stickers.is_empty():
			for each_sticker: Sticker in needed_stickers:
				## useful when loading from save file first time,
				add_child(each_sticker)
				each_sticker.set_spread(_spread.get_spread_index())
				each_sticker.activate()
	else:
		hide()
		for each_child in get_children():
			if each_child is Sticker:
				each_child.deactivate()

func _before_spread_change() -> void:
	if !_spread:
		return
	var stickers : Array[Sticker]
	for each_child in get_children():
		if each_child is Sticker:
			if each_child.match_spread(_spread.get_spread_index()):
				if each_child.is_fully_on_spread():
					stickers.append(each_child)
				else:
					each_child.spread_rejected()
	_spread.set_stickers(stickers)

func try_to_stick(sticker: Sticker) -> void:
	sticker.set_spread(_spread.get_spread_index())
	sticker.reparent(self, true)

func _setup_collition_shape() -> void:
	pages_collision.set_disabled(_spread == null)
	for each_child in area_void.get_children():
		if each_child is CollisionShape2D:
			each_child.set_disabled(_spread == null)
	if !_spread:
		
		return
	var has_left := _spread.get_left_page() != null
	var has_right := _spread.get_right_page() != null
	if has_left and has_right:
		pages_collision.get_shape().size.x = Utilties.PAGE_SIZE.x * 2
		pages_collision.position.x = 0
		boundry_left.position.x = Utilties.PAGE_SIZE.x * -1
		boundry_right.position.x = Utilties.PAGE_SIZE.x
	elif has_left or has_right:
		pages_collision.get_shape().size.x = Utilties.PAGE_SIZE.x
		pages_collision.position.x = Utilties.PAGE_SIZE.x / 2
		if has_left:
			pages_collision.position.x *= -1
			boundry_left.position.x = Utilties.PAGE_SIZE.x * -1
			boundry_right.position.x = 0
		elif has_right:
			boundry_left.position.x = 0
			boundry_right.position.x = Utilties.PAGE_SIZE.x

func _on_sticker_lifted(node: Sticker) -> void:
	move_child(node, -1)

func _on_child_entered_tree(node: Node) -> void:
	if node is Sticker:
		if !node.picked_up.is_connected(_on_sticker_lifted):
			node.picked_up.connect(_on_sticker_lifted)

func _on_child_exiting_tree(node: Node) -> void:
	if node is Sticker:
		if node.picked_up.is_connected(_on_sticker_lifted):
			node.picked_up.disconnect(_on_sticker_lifted)

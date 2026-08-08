class_name StickerTray extends Area2D

static var _instance : StickerTray

@onready var close_button: Button = %CloseButton
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _init() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)

func _ready() -> void:
	_instance = self
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)
	close_button.pressed.connect(_on_save)
	#_return_home( StickerManager_AL.request_sticker(Utilties.StickerID.GODOT))
	#set_collision_mask_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)
	%Button.pressed.connect(from_save) ## Debug 

static func get_instance() -> StickerTray: return _instance

static func return_to_tray(sticker: Sticker, use_random_pos := true) -> bool:
	if _instance:
		return _instance._return_home(sticker, use_random_pos)
	return false

func _return_home(sticker: Sticker, use_random_pos := true) -> bool:
	if sticker:
		if sticker.is_visible_in_tree():
			if sticker.get_parent() == self:
				return true
			sticker.reparent(self)
		else:
			add_child(sticker)
		if use_random_pos:
			sticker.position = ( Vector2( randf(), randf()  ) * collision_shape_2d.get_shape().size )  - ( collision_shape_2d.get_shape().size * .5 )
			sticker.rotation = randf_range(0, TAU)
		return true
	return false

func _get_random_position(_depth := 5) -> Vector2 :
	var out : Vector2 = ( Vector2( randf(), randf()  ) * collision_shape_2d.get_shape().size )  - ( collision_shape_2d.get_shape().size * .5 )
	_depth -= 1
	if _depth <= 0:
		return out
	for each_child in get_children():
		if out.distance_squared_to(each_child.position) < 100:
			return _get_random_position(_depth)
	return out

func _on_sticker_lifted(node: Sticker) -> void: move_child(node, -1)

func _on_child_entered_tree(node: Node) -> void:
	if node is Sticker:
		if !node.picked_up.is_connected(_on_sticker_lifted):
			node.picked_up.connect(_on_sticker_lifted)

func _on_child_exiting_tree(node: Node) -> void:
	if node is Sticker:
		if node.picked_up.is_connected(_on_sticker_lifted):
			node.picked_up.disconnect(_on_sticker_lifted)

#region SaveLoad

static func request_save() -> void:
	if _instance:
		_instance._on_save()

func _on_save() -> void:
	var stickers : Array[StickerResource] = []
	var sticker_info : StickerResource
	for each_child in get_children():
		if each_child is Sticker:
			sticker_info = each_child.get_info()
			if sticker_info:
				stickers.append(sticker_info)
	SaveResource.get_save().set_sticker_tray_stickers(stickers)

static func request_load() -> void:
	if _instance:
		_instance.from_save()

func from_save() -> void:
	var data := SaveResource0.get_save()
	# remove any default/current children
	for each_child in get_children():
		if each_child is Sticker:
			each_child.queue_free()
	# stickers from memory 
	for each_new in data.get_tray_stickers():
		if each_new.is_visible_in_tree():
			if !each_new.get_parent() == self:
				StickerTray.return_to_tray(each_new)
		else:
			add_child( each_new)

#endregion 

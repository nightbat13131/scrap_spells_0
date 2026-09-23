class_name StickerSocket extends StickerEntity

@export var socket_area : Area2D
@export var sprite_gemed: Sprite2D
var _gems : Array[StickerGem]

func _ready() -> void:
	assert(_info is StickerResource_Socket)
	assert(socket_area)
	assert(sprite_gemed)
	socket_area.set_collision_mask_value(Utilties.COLLISION_LAYER.GEM, true)
	super._ready()

func _post_ready() -> void:
	super._post_ready()
	_info.gem_changed.connect(_on_gem_updated) # connecting during ready was somehow connecting to the wrong resource. 
	_gem_entities_updated()

func _connect_children() -> void:
	super._connect_children()
	socket_area.area_entered.connect(_on_socket_area_entered)
	socket_area.area_exited.connect(_on_socket_area_exited)

func _on_socket_area_entered(area: Node2D) -> void:
	area = area.get_parent()
	if area is StickerGem:
		print("gem enter")
		if !_gems.has(area):
			_gems.append(area)
		_gem_entities_updated()

func _on_socket_area_exited(area: Node2D) -> void:
	area = area.get_parent()
	if area is StickerGem:
		while _gems.has(area):
			_gems.erase(area)
		_gem_entities_updated()

func _gem_entities_updated() -> void:
	if !_gems.is_empty():
		get_info().try_insert_gem(_gems[0].get_info())
	else:
		get_info().try_insert_gem(null)

func _on_gem_updated() -> void:
	var _gem_info : StickerResource = get_info().get_gem_info()
	if _gem_info == null:
		sprite_gemed.set_modulate(Color.TRANSPARENT)
	else:
		sprite_gemed.set_modulate(_gem_info.get_gem_color())

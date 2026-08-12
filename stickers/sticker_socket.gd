extends Sticker


@export var socket_area : Area2D
@export var sprite_gemed: Sprite2D
var _gems : Array[StickerGem]
var _active_gem : StickerResource


func _ready() -> void:
	assert(_info.is_socket())
	assert(socket_area)
	assert(sprite_gemed)
	socket_area.set_collision_mask_value(Utilties.COLLISION_LAYER.GEM, true)
	super._ready()

func _post_ready() -> void:
	super._post_ready()
	_gem_updated()

func _connect_children() -> void:
	super._connect_children()
	socket_area.area_entered.connect(_on_area_entered)
	socket_area.area_exited.connect(_on_area_exited)

func _on_area_entered(area: Node2D) -> void:
	prints("in", area)
	area = area.get_parent()
	if area is StickerGem:
		if !_gems.has(area):
			_gems.append(area)
		_gem_updated()

func _on_area_exited(area: Node2D) -> void:
	prints("out", area)
	area = area.get_parent()
	if area is StickerGem:
		while _gems.has(area):
			_gems.erase(area)
		_gem_updated()

func _gem_updated() -> void:
	var _first : StickerResource
	if !_gems.is_empty():
		_first = _gems[0].get_info()
	if _first == _active_gem: # no change
		return
	_active_gem = _first
	if _first == null:
		sprite_gemed.set_modulate(Color.TRANSPARENT)
	else:
		sprite_gemed.set_modulate(_first.gem_color)

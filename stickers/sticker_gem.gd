class_name StickerGem extends StickerEntity

@export var gem_area : Area2D
@onready var gem: Sprite2D = %Gem

func _ready() -> void:
	super._ready()
	assert(_info is StickerResource_Gem)
	_on_socketed(false)
	assert(gem_area)
	gem_area.set_collision_layer_value(Utilties.COLLISION_LAYER.GEM, true)

func _post_ready() -> void:
	super._post_ready()
	if _info is StickerResource_Gem: # trigger intelesence
		_info.socketed.connect(_on_socketed)

func _on_socketed(is_socked: bool) -> void:
	gem.set_visible(is_socked)

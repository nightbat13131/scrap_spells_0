class_name StickerGem extends Sticker

@export var gem_area : Area2D

func _ready() -> void:
	super._ready()
	assert(_info.is_gem())
	assert(gem_area)
	gem_area.set_collision_layer_value(Utilties.COLLISION_LAYER.GEM, true)

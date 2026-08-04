class_name OutsideSpread extends Area2D


func _ready() -> void:
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)
	#set_collision_mask_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)

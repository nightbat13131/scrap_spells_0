class_name OverlappingUI extends Area2D
## Used to detect when the sticker is overlaping with UI space 
## Need this because dropping the sticker over buttons breaks the abilty to pickup the sticker

func _ready() -> void:
	set_collision_layer_value(Utilties.COLLISION_LAYER.STICKER_PAPER, true)

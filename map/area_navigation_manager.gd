class_name AreaNavigationManager extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for each in get_children():
		if each is Area3D_Mousable:
			each.triggered.connect(_on_nav_press)



func _on_nav_press(thing: Area3D_Mousable) -> void:
	if thing:
		if thing.get_nav_link():
			thing.get_nav_link().trigger_navigation()

class_name ClickNavigate extends Area3D_Mousable

# for thing connected to trigger to use
@export var _nav_link : View3DNavigationLink

func _ready() -> void: 
	super._ready()
	triggered.connect(_on_triggered)

func get_nav_link() -> View3DNavigationLink: return _nav_link

func _on_triggered(_thing: Variant) -> void:
	if _nav_link:
		_nav_link.trigger_navigation()

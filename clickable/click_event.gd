class_name ClickEvent extends Area3D_Mousable

@export var _event: Event
@export var untrigger_on_view_break := false


func _ready() -> void:
	assert(_event)
	super._ready()
	triggered.connect(_on_triggered)

func _on_triggered(_thing: Variant) -> void:
	_event.trigger()
	if _thing:
		if _usable_dependency:
			_usable_dependency.be_used_up(_event)

func _on_view_change(_is_focused: bool) -> void:
	super._on_view_change(_is_focused)
	if untrigger_on_view_break and !_is_focused:
		_event.un_trigger()

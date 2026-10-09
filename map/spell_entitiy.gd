class_name SpellEntity extends Node3D

@export var _spell: Spell
@export var _duration := 1.0 

func _ready() -> void:
	hide()
	if _spell:
		_spell.request_cast.connect(_on_cast)

func _on_cast() -> void:
	assert(_spell)
	show()
	var tween := get_tree().create_tween()
	tween.tween_method( rotate_x, 0.0, 3600*.5, _duration)
	await tween.finished
	hide()
	_spell.casting_complete()

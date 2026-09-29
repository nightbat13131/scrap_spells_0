class_name SpellEntity extends Node3D

@export var _spell: Spell

func _ready() -> void:
	hide()
	if _spell:
		_spell.request_cast.connect(_on_cast)

func _on_cast() -> void:
	assert(_spell)
	show()
	await get_tree().create_timer(1.).timeout
	hide()
	_spell.casting_complete()

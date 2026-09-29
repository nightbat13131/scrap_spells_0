extends Node3D
# open door when spell is cast

@export var _event : Event
@export var post_event_navigate : View3DNavigationLink
@onready var hint_key_sun: Sprite3D = %Hint_KeySun
@export var spell_resource: Spell

func _ready() -> void:
	assert(_event)
	_event.triggered.connect(_on_triggered)
	set_rotation(Vector3(0,0,0))

## Find the animation player to send the trigger
func _on_triggered(is_triggered: bool) -> void:
	if is_triggered:
		print("Show spell, open door animation")
		for each0 in get_children():
			if each0 is AnimationPlayer:
				__open_door(each0)
				return
			for each1 in each0.get_children():
				if each1 is AnimationPlayer:
					__open_door(each1)

func __open_door(door_player: AnimationPlayer) -> void:
	spell_resource.cast()
	await spell_resource.cast_complete
	door_player.play("handle|open|Animation Base Layer")
	await door_player.animation_finished
	hint_key_sun.hide()
	if post_event_navigate:
		post_event_navigate.trigger_navigation()
	door_player.play("door|open|Animation Base Layer")

extends Node3D
# open door when spell is cast

@export var _event : Event



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(_event)
	_event.triggered.connect(_on_triggered)
	set_rotation(Vector3(0,0,0))

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
				

func __open_door(player: AnimationPlayer) -> void:
	player.play("handle|open|Animation Base Layer")
	await player.animation_finished
	
	player.play("door|open|Animation Base Layer")
	pass

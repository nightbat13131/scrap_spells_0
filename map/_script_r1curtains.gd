extends Node3D

@export var _event : Event
@export var _environment :Environment


@onready var _left: MeshInstance3D = %left
@onready var _right: MeshInstance3D = %right
@onready var windowlight: AreaLight3D = %Windowlight



var _init_size : Vector3
var _left_init_pos : Vector3
var _right_init_pos : Vector3
var _init_ambiant : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _event:
		_event.triggered.connect(_on_triggered)
	if _environment:
		_init_ambiant = _environment.get_ambient_light_sky_contribution()
		
	_init_size = _left.get_mesh().get_size()
	_left_init_pos = _left.get_position()
	_right_init_pos = _right.get_position()
	_on_triggered(false)
	pass # Replace with function body.

func _on_triggered(_is_triggered) -> void:
	prints("eee", _is_triggered, _init_size)
	var _new_size = _init_size
	var _left_pos = _left_init_pos
	var _right_pos = _right_init_pos
	var _ambiant = _init_ambiant
	if _is_triggered:
		_new_size.z *= .1
		_left_pos.z -= _init_size.z *.5
		_right_pos.z += _init_size.z *.5
		_ambiant *= 5
	windowlight.set_visible(_is_triggered)
	_left.get_mesh().set_size(_new_size)
	_left.set_position(_left_pos)
	_right.set_position(_right_pos)
	if _environment:
		_environment.set_ambient_light_sky_contribution(_ambiant)

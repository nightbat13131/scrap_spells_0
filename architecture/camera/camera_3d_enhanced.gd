class_name Camera3DEnhanced extends Camera3D
## manipulating stuff connected to the 3d view

@export var spell_sampler :MeshInstance3D
@export var spell_sample_material : Material

static var _instance : Camera3DEnhanced

var _sub_viewport : SubViewport
var _viewport_size : Vector2
var screen_scale := 1/ 1000.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance = self
	_on_viewport_size_change.call_deferred()
	_spell_cast(null)

static func set_sub_viewport(thing: Viewport) -> void:
	if _instance:
		_instance._set_sub_viewport(thing)

func _set_sub_viewport(thing: Viewport) -> void:
	_sub_viewport = thing
	thing.size_changed.connect(_instance._on_viewport_size_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !spell_sampler.is_visible():
		return
	var mouse_pos = _sub_viewport.get_mouse_position()
	mouse_pos -= _viewport_size*.5
	spell_sampler.position = Vector3(
		mouse_pos.x * screen_scale, 
		mouse_pos.y * screen_scale*-1, 
		-.5
	)#.limit_length(1.0)


static func spell_cast(spell: StickerResource) -> void:
	if _instance:
		_instance._spell_cast(spell)

func _spell_cast(spell: StickerResource) -> void:
	#var color := Color.TRANSPARENT
	if spell:
		if spell.is_spell():
			if spell_sample_material:
				spell_sampler.show()
				spell_sample_material.set_albedo(spell.get_gem_color())
				return
	spell_sampler.hide()

func _on_viewport_size_change() -> void:
	_viewport_size = _sub_viewport.size

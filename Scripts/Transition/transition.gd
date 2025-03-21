extends ColorRect

var value: float = 0

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	modulate.r = 0
	modulate.g = 0
	modulate.b = 0
	visible = true
	fade_out()

func _process(delta: float) -> void:
	modulate.a += value * delta

func fade_in(scene: String):
	visible = true
	await get_tree().create_timer(1.5).timeout
	modulate.a = 0
	value = 1.5
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(scene)

func fade_out():
	modulate.a = 1
	value = -1.5
	

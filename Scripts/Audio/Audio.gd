extends VBoxContainer

@export var bus_name: String
@onready var h_slider: HSlider = $HSlider

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
	AudioServer.set_bus_volume_db(
		bus_index,
		Globals.Audio_bus_name[String(bus_name)]
	)
	
	h_slider.value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)
	
	$HSlider.value_changed.connect(_on_value_changed)
	
	$HSlider/Label.text = bus_name + " volume"

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
	Globals.Audio_bus_name[String(bus_name)] = linear_to_db(value)
#
#func _process(delta: float) -> void:
	#print(AudioServer.get_bus_volume_db(bus_index))

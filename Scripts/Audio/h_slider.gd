extends VBoxContainer


@export var bus_name: String
@onready var h_slider: HSlider = $HSlider

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	$HSlider.value_changed.connect(_on_value_changed)
	
	h_slider.value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)
	$HSlider/Label.text = bus_name + " volume"

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)

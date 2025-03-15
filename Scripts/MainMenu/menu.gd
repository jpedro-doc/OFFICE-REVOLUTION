extends Control

var press_space: Node = null
@onready var black_background: ColorRect = $BlackBackground
@export var increase_value: float = 1.25
var value: float = 0.0
signal space_pressed


func _ready() -> void:
	press_space = get_node("MarginContainer/HBoxContainer/VBoxContainer/PressSpace")
	space_pressed.connect(fade_out)
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"): 
		press_space.blink_faster()
		space_pressed.emit()
		
	black_background.modulate.a += value * delta
	
func fade_out():
	await get_tree().create_timer(1.5).timeout
	value = increase_value
	

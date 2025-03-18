extends Control
@onready var black_background: ColorRect = $BlackBackground

var press_space: Node = null
var value: float = 0.0

var space_not_pressed: bool = true


func _ready() -> void:
	Music.main_menu_music.play()
	press_space = get_node("MarginContainer/HBoxContainer/VBoxContainer/PressSpace")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space") and space_not_pressed: 
		Sfx.start_sfx.play()
		space_not_pressed = false
		press_space.blink_faster()
		black_background.fade_in("res://Scenes/SelectMenu/select_menu.tscn")
	

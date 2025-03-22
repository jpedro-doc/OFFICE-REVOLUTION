extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/MarginContainer/Button

func _ready() -> void:
	if get_parent().name == "Game": button.visible = true
	else: button.visible = false
	get_tree().paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		get_tree().paused = not get_tree().paused
		visible = not visible
		


func _on_button_pressed() -> void:
	var black_background:Node = get_parent().get_node("BlackBackground")
	Music.stop_all()
	Sfx.exit_level.play()
	black_background.fade_in("res://Scenes/SelectMenu/select_menu.tscn")
	$MarginContainer/VBoxContainer/MarginContainer/Button.disabled = true
	get_parent().move_child(black_background, -1)

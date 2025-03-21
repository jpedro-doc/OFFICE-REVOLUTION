extends Node2D

var move_distance: int = -1
var limit_down: int = -1
var limit_up: int = 0
var current_limit: int = 0
var space_pressed: bool = false

@onready var enemys_container: VBoxContainer = $"../../EnemysContainer"
@onready var black_background: ColorRect = $"../../../../BlackBackground"


func _ready() -> void:
	limit_down = enemys_container.get_child_count() - 1  
	move_distance = enemys_container.get("theme_override_constants/separation")

func _process(delta: float) -> void:
	if space_pressed:
		return
		
	if Input.is_action_just_pressed("down") and current_limit < limit_down:
		current_limit += 1
		global_position.y += move_distance
	
	if Input.is_action_just_pressed("up") and current_limit > limit_up:
		current_limit -= 1
		global_position.y -= move_distance
	
	if Input.is_action_just_pressed("Space"):
		space_pressed = true
		Sfx.start_sfx.play()
		var enemy = enemys_container.get_child(current_limit)
		black_background.fade_in(enemy.enemy_scene)
		

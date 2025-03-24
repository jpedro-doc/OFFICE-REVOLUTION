extends Node2D

var move_distance_y: int = -1
var move_distance_x: int = -1
var limit_down: int = -1
var limit_up: int = 0
var side:bool = false # false = left, true = right
var current_limit: int = 0
var space_pressed: bool = false
var max_vida: int = 3
var vida_atual: int


@onready var enemys_container: VBoxContainer = $"../EnemysContainer"
@onready var appear_timer: Timer = $AppearTimer
@onready var dissapear_timer: Timer = $DissapearTimer


func _ready() -> void:

	vida_atual = max_vida
	appear_timer.wait_time = 0.1
	dissapear_timer.wait_time = 0.1
	limit_down = enemys_container.get_child_count() - 1  
	move_distance_y = enemys_container.get("theme_override_constants/separation")
	
	dissapear_timer.timeout.connect(blink)

func perder_vida():

	vida_atual -= 1
	print("Vida restante: ", vida_atual)
	if vida_atual <= 0:
		game_over()

func game_over():
	print("Game Over!")
	get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if space_pressed:
		return
		
	if Input.is_action_just_pressed("down") and current_limit < limit_down:
		current_limit += 1
		global_position.y += move_distance_y
	
	if Input.is_action_just_pressed("up") and current_limit > limit_up:
		current_limit -= 1
		global_position.y -= move_distance_y
	
	if Input.is_action_just_pressed("Space"):
		space_pressed = true
		blink()
		Sfx.start_sfx.play()
		var enemy = enemys_container.get_child(current_limit)
		Globals.enemy_chosen = enemy.enemy_name
		get_tree().root.get_node("SelectMenu/BlackBackground").fade_in(enemy.enemy_scene)
	
	if position.y > get_viewport_rect().size.y:
		get_parent().perder_vida() 
		queue_free()  
		

func blink() -> void:
	self.visible = false
	appear_timer.start()
	await appear_timer.timeout
	self.visible = true
	dissapear_timer.start()

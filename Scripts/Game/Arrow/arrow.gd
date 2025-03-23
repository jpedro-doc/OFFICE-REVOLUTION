extends Node2D
class_name Arrow_abstract

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var speed:float = 100.0

#3.33333333333333

func _ready() -> void:
	sprite_2d.use_parent_material = true
	scale = Vector2(0.5, 0.5)

func _process(delta: float) -> void:
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$"../BlankArrows".consecutive_hits = 0
	$"../BlankArrows".score -= 25
	get_parent().perder_vida()
	queue_free()

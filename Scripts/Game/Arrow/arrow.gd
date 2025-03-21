extends Node2D
class_name Arrow_abstract

@export var speed:float = 100.0

@export var key: String #left down up right

func _ready() -> void:
	scale = Vector2(0.5, 0.5)

func _process(delta: float) -> void:
	position.y += speed * delta

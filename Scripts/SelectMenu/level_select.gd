extends Control

@export var enemy_name: String
@export var enemy_scene:String 
@export var enemy_sprite:String

func _ready() -> void:
	$Label.text = enemy_name
	$Sprite2D.texture = load(enemy_sprite)

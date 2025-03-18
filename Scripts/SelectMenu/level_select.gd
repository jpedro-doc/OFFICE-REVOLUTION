extends Control

@export var enemy_name: String = ""
@export var enemy_scene:String 

func _ready() -> void:
	$HBoxContainer/Label.text = enemy_name

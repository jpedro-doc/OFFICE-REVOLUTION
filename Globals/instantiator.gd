extends Node2D
class_name Instantiator

func _ready() -> void:
	var transition = preload("res://Scenes/transition.tscn").instantiate()
	get_parent().add_child.call_deferred(transition)
	var config = preload("res://Scenes/ConfigMenu/ConfigMenu.tscn").instantiate()
	get_parent().add_child.call_deferred(config)


	
	

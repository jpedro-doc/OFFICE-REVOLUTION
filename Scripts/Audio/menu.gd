extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		get_tree().paused = not get_tree().paused
		visible = not visible
		

extends Node2D

@onready var left: Sprite2D = $left
@onready var down: Sprite2D = $down
@onready var up: Sprite2D = $up
@onready var right: Sprite2D = $right

var score = 0

var arrow_pressed_coords = 2

@onready var arrow_select = get_parent()

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	left.frame_coords.y = 0
	down.frame_coords.y = 0
	up.frame_coords.y = 0
	right.frame_coords.y = 0
	
	if Input.is_action_just_pressed("left"):
		left.frame_coords.y = arrow_pressed_coords
		if $left/Area2D.has_overlapping_areas():
			$left/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= 1
			arrow_select.perder_vida()
	
	if Input.is_action_just_pressed("down"):
		down.frame_coords.y = arrow_pressed_coords
		if $down/Area2D.has_overlapping_areas():
			$down/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= 1
			arrow_select.perder_vida()
			
	if Input.is_action_just_pressed("up"):
		up.frame_coords.y = arrow_pressed_coords
		if $up/Area2D.has_overlapping_areas():
			$up/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= 1
			arrow_select.perder_vida()
			
	if Input.is_action_just_pressed("right"):
		right.frame_coords.y = arrow_pressed_coords
		if $right/Area2D.has_overlapping_areas():
			$right/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= 1
			arrow_select.perder_vida()
			

func get_rid(object:Node2D):
	object.get_parent().queue_free()
	

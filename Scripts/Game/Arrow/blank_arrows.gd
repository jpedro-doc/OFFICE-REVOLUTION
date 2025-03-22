extends Node2D

@onready var left: Sprite2D = $left
@onready var down: Sprite2D = $down
@onready var up: Sprite2D = $up
@onready var right: Sprite2D = $right

var score:int = 0: set = _set_score_label
var hit_score:int = 50
var miss_score:int = 25
var rainbow_mult:int = 5

var arrow_pressed_coords:int = 2

@onready var game = get_parent()

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
			score -= miss_score
			game.perder_vida()
			


	if Input.is_action_just_pressed("down"):
		down.frame_coords.y = arrow_pressed_coords
		if $down/Area2D.has_overlapping_areas():
			$down/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= miss_score
			game.perder_vida()
	

	if Input.is_action_just_pressed("up"):
		up.frame_coords.y = arrow_pressed_coords
		if $up/Area2D.has_overlapping_areas():
			$up/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= miss_score
			game.perder_vida()
		
	if Input.is_action_just_pressed("right"):
		right.frame_coords.y = arrow_pressed_coords
		if $right/Area2D.has_overlapping_areas():
			$right/Area2D.get_overlapping_areas().filter(get_rid)
		else:
			score -= miss_score
			game.perder_vida()

func get_rid(object:Node2D):
	score += hit_score
	object.get_parent().queue_free()
	
func _set_score_label(new_value:int):
	score = new_value
	$"../Label".text = "score: " + str(new_value)

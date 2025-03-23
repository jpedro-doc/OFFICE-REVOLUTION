extends Node2D

@export var difference: float
@export var max_vida: int = 3

@onready var vida: Label = $vida
@onready var quirrel: Node2D = $Quirrel
@onready var rainbow: Sprite2D = $rainbow

var vida_atual: int  : set = _set_vida

const ARROW_LEFT = preload("res://Scenes/Game/Arrows/arrow_left.tscn")
const ARROW_DOWN = preload("res://Scenes/Game/Arrows/arrow_down.tscn")
const ARROW_RIGHT = preload("res://Scenes/Game/Arrows/arrow_right.tscn")
const ARROW_UP = preload("res://Scenes/Game/Arrows/arrow_up.tscn")

var note_names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

var note_arrows = { 'C':"left", 'C#':"left", 'D':"left", 'D#':"down", 'E':"down", 'F':"down", 'F#':"right", 'G':"right", 'G#':"right", 'A':"up", 'A#':"up", 'B':"up"}
var arrow = {
	"left": ARROW_LEFT,
	"right": ARROW_RIGHT,
	"up": ARROW_UP,
	"down": ARROW_DOWN
	} 

#var hold:int
	#for time in json_as_dict:
		#if hold == int(time.time):
			#continue
		#get_tree().create_timer(time.time).timeout.connect(spawn_arrow.bind(time.note))
		#hold = time.time

func _ready() -> void:
	vida.text = "Vida: " + str(max_vida)
	Music.main_menu_music.stop()
	var file: String
	if Globals.enemy_chosen == "janitor": 
		Music.janitor_song.play()
		file = Globals.NOTES_CHART_JANITOR
	
	if Globals.enemy_chosen == "secretary": 
		Music.secretary_song.play()
		file = Globals.NOTES_CHART_SECRETARY
		
	if Globals.enemy_chosen == "boss": 
		Music.boss_song.play()
		file = Globals.NOTES_CHART_BOSS
		
	if Globals.enemy_chosen == "custom":
		Music.custom_song.play()
		file = Globals.NOTES_CHART
		$AnimatedSprite2D.sprite_frames = Globals.sprite_frames_path
		$AnimatedSprite2D.play()
	
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	var previous_arrow: String
	var previous_time: float = 10

	for time in json_as_dict:
		if time.note == "N/A": continue
		if note_arrows[time.note] == previous_arrow or abs(previous_time - time.time) < difference:
			continue
		get_tree().create_timer(time.time).timeout.connect(spawn_arrow.bind(time.note))
		previous_arrow = time.note
		previous_time = time.time

func perder_vida():
		vida_atual -= 1
		Sfx.miss.play()
		if vida_atual <= 0:
			game_over()

func ganhar_vida():
	if vida_atual < max_vida:
		vida_atual += 1

func game_over():
	get_tree().reload_current_scene()

func spawn_arrow(note: String):
	var arrow_direction = note_arrows[note]
	var arrow_colored = arrow[arrow_direction].instantiate()
	quirrel.add_child(arrow_colored)

func _set_vida(new_value: int):
	vida.text = "Vida: " + str(new_value)

func prepare_rave():
	if quirrel.get_child(-1) is Node2D:
		quirrel.get_child(-1).sprite_2d.use_parent_material = false
	
func start_rave():
	quirrel.get_children().filter(func(arrows:Node2D):
		arrows.sprite_2d.use_parent_material = false
		)

	
	
	

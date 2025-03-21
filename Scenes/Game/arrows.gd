extends Sprite2D

@onready var Seta_que_cai1=preload("res://Scenes/Game/setas_que_caem.tscn")
@export var key_name: String = ""


func _process(delta):
	if Input.is_action_just_pressed(key_name):
		Cria_seta_que_cai()
		

func Cria_seta_que_cai():
	var sqc_inst = Seta_que_cai1.instantiate()
	call_deferred("add_child",sqc_inst)
	Seta_que_cai1.Setup(position.x)

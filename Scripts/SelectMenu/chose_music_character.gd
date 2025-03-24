extends Control

@onready var file_dialog_song: FileDialog = $MarginContainer/VBoxContainer/HBoxContainer/Button2/FileDialog
@onready var file_dialog_char: FileDialog = $MarginContainer/VBoxContainer/HBoxContainer/Button/FileDialog
@onready var confirm_button: Button = $MarginContainer/VBoxContainer/Button
#$FileDialog.set_filters(["*vox ; Voxlap super blocky 3D format"])

func _ready() -> void:
	file_dialog_song.set_filters(["*mp3", "*wav"])
	file_dialog_char.set_filters(["*gif"])


func _process(delta: float) -> void:
	if file_dialog_char.current_file and file_dialog_song.current_file:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true

func _on_button_2_pressed() -> void:
	Globals.enemy_chosen = "custom"
	Globals.sprite_frames_path = load(file_dialog_char.current_path)
	
	var musicStream = load(file_dialog_song.current_path)
	Music.custom_song.stream = musicStream
	
	var output = []
	var python = "C:/Users/davi5/AppData/Local/Microsoft/WindowsApps/python3.11.exe"
	var script = "audio.py"
	var song_path = file_dialog_song.current_path
	
	var result = OS.execute(python, [script, song_path], output, true)
	
	if result == 0:
		print("✅ Python ran successfully!")
	else:
		print("❌ Python failed. Output:\n" + str(output))
	print(output)
	get_node("BlackBackground").fade_in("res://Scenes/Game/Levels/Custom_level.tscn")

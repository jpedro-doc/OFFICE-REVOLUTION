extends Node2D

@onready var main_menu_music: AudioStreamPlayer2D = $MainMenuMusic
@onready var janitor_song: AudioStreamPlayer2D = $JanitorSong
@onready var secretary_song: AudioStreamPlayer2D = $SecretarySong
@onready var boss_song: AudioStreamPlayer2D = $BossSong
@onready var custom_song: AudioStreamPlayer2D = $CustomSong

func stop_all():
	for song in get_children():
		song.stop()
		

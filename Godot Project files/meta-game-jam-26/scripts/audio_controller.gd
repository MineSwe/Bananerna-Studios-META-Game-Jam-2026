extends Node

@onready var main_menu_player: AudioStreamPlayer = get_node("MainMenuPlayer")
@onready var bgm_player: AudioStreamPlayer = get_node("BGMPlayer")
@onready var intro_player: AudioStreamPlayer = get_node("IntroPlayer")
@onready var bossplayer: AudioStreamPlayer = $Bossplayer

var main_menu_is_playing = false

func bgm_play():
	main_menu_stop()
	bgm_player.play()
	Intro_stop()
	bossplayer.stop()
	
func bgm_stop():
	bgm_player.stop()
	
func main_menu():
	main_menu_player.play()
	main_menu_is_playing = true
	
func main_menu_stop():
	main_menu_player.playing = false
	main_menu_player.stop()
	
func Intro_play():
	intro_player.play()
	
func Intro_stop():
	intro_player.stop()

func boss_music_play():
	main_menu_player.playing = false
	main_menu_stop()
	bgm_stop()
	Intro_stop()
	bossplayer.play()

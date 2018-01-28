extends Node

var cursor = preload("res://data/game/puntero.png")
var notepad = preload("res://data/game/help/HelpWindow.tscn")

var wallpapers = [preload("res://data/game/wallpaper/plain.png"),\
					preload("res://data/game/wallpaper/fondo1.png"),\
					preload("res://data/game/wallpaper/fondo2.png"),\
					preload("res://data/game/wallpaper/fondo3.png"),\
					preload("res://data/game/wallpaper/fondo4.png"),\
					preload("res://data/game/wallpaper/fondo5.png")]

var lose_sound = preload("res://data/SFX/Police.wav")
var clicks = [preload("res://data/SFX/Click 1.wav"), preload("res://data/SFX/Click 2.wav"), preload("res://data/SFX/Click 3.wav")]
var start = preload("res://data/SFX/sega theme.wav")
var songs = preload("res://data/music/Theme song (Vaporwave Remix).wav")

onready var sound = get_node("sound")
onready var vega_sound = $Vega

func _ready():
	#$Centerer/Hackerexe.hide()
	var screen = OS.get_screen_size()
	var centro_x = (screen.x - 1024) / 2
	var centro_y = (screen.y - 768) / 2
	#$Centerer.translate(Vector2(centro_x, centro_y))
	
	#$Centerer/Hackerexe.desktop = self
	$Centerer/HackerHP.desktop = self
	#sound.set_stream(start)
	#sound.play(0)
	
	Input.set_custom_mouse_cursor( cursor )
	vega_sound.play(0)
	
func enable_button():
	$Centerer/Icono.disabled = false
	
func add_time( amount ):
	$Centerer/HackerHP.add_time(amount)

func hide_hhp():
	$Centerer/HackerHP.hide()
	
func lose():
	$Centerer/Icono.disabled = false
	$Centerer/Hackerexe.queue_free()
	sound.set_stream(lose_sound)
	sound.play(0)
	var blue_screen = get_node("Blue_Screen")
	blue_screen.visible = true

func win():
	$Centerer/Icono.disabled = false
	$Centerer/Hackerexe.queue_free()

func random_wallpaper():
	var select = randi() % wallpapers.size()
	$Centerer/Fondo.texture = wallpapers[select]

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_sound_finished():
	sound.stop()
	var blue_screen = get_node("Blue_Screen")
	blue_screen.visible = false


func _on_HelpMission_button_up():
	randomize()
	sound.set_stream(clicks[randi()%3])
	sound.play(0)
	var n = notepad.instance()
	n.translate(Vector2(123, 66))
	n.read_from_file("Mission.txt")
	add_child(n)


func _on_HelpHowTo_button_up():
	randomize()
	sound.set_stream(clicks[randi()%3])
	sound.play(0)
	var n = notepad.instance()
	n.translate(Vector2(143, 76))
	n.read_from_file("HowTo.txt")
	add_child(n)


func _on_Start_Button_toggled( button_pressed ):
	randomize()
	sound.set_stream(clicks[randi()%3])
	sound.play(0)
	var menu = get_node("Centerer/Fondo/Start_Menu")
	menu.visible = not menu.visible


func _on_Turn_Off_pressed():
	get_tree().quit()


func _on_Icono_pressed():
	randomize()
	sound.set_stream(clicks[randi()%3])
	sound.play(0)


func _on_CD_pressed():
	sound.set_stream(songs)
	sound.play(0)


func _on_Vega_finished():
	vega_sound.stop()

extends Node

var cursor = preload("res://data/game/puntero.png")
var lose_sound = preload("res://data/SFX/Police.wav")

onready var sound = get_node("sound")

func _ready():
	#$Centerer/Hackerexe.hide()
	var screen = OS.get_screen_size()
	var centro_x = (screen.x - 1024) / 2
	var centro_y = (screen.y - 768) / 2
	$Centerer.translate(Vector2(centro_x, centro_y))
	
	#$Centerer/Hackerexe.desktop = self
	$Centerer/HackerHP.desktop = self
	
	Input.set_custom_mouse_cursor( cursor )
	
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
	# PANTALLA Y SONIDO DE PERDER

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_sound_finished():
	sound.stop()

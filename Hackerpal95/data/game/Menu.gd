extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#var hackerexe = load("res://data/game/hackerexe/Hackerexe.tscn")
var cursor = preload("res://data/game/puntero.png")

func _ready():
	$Centerer/Hackerexe.hide()
	var screen = OS.get_screen_size()
	var centro_x = (screen.x - 1024) / 2
	var centro_y = (screen.y - 768) / 2
	$Centerer.translate(Vector2(centro_x, centro_y))
	
	$Centerer/Hackerexe.desktop = self
	
	Input.set_custom_mouse_cursor( cursor )
	
	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

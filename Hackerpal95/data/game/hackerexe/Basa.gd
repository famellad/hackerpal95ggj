extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var infected = false
var coords = Vector2(0, 0)
var hackerexe

var diff = "insane"

func _ready():
	set_process(false)
	pass
	
func activate():
	pass

func infect():
	infected = true
	$NodeLabel.text = "xx.xx.xx.xx"
	$Sprite.frame = 1

func _process(delta):
	pass
	

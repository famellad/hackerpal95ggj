extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var infect_c = 2
var infect_t = 0.25

var infected = false
var coords = Vector2(0, 0)
var hackerexe

var diff = "insane"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(false)
	pass

func infect():
	infected = true
	$NodeLabel.text = "xx.xx.xx.xx"
	$Sprite.frame = 1
	

extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var infected = false
var coords = Vector2(0, 0)
var hackerexe
var diff = "easy"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#infect()
	pass

func infect():
	infected = true
	$NodeLabel.text = "xx.xx.xx.xx"
	$Sprite.frame = 1

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

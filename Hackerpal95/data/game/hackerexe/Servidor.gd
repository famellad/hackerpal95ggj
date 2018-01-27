extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var infect_c = 2
var infect_t = 0.5

var infected = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	infect()
	pass

func infect():
	infected = true
	$Sprite.frame = 1
	set_process(true)

func _process(delta):
	infect_t -= delta
	if infect_t < 0:
		infect_t = 0.5
		$Sprite.frame = infect_c
		infect_c += 1
		
		if infect_c == 5:
			set_process(false)
	

extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

static func generate_random_ip():
	ip = str(randi() % 255) + "." + str(randi() % 255) + "." + str(randi() % 127 + 255) + "." + str(randi() % 255)

extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	text = generate_random_ip()
	pass

func generate_random_ip():
	return str(randi() % 255) + "." + str(randi() % 99) + "." + str(randi() % 99) + "." + str(randi() % 127 + 255)
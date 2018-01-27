extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var last_coord = Vector2(0, 0)

var x_offset = 56 + 96
var y_offset = 88

var celu = preload("res://data/game/hackerexe/Celu.tscn")
var pc = preload("res://data/game/hackerexe/PC.tscn")
var servi = preload("res://data/game/hackerexe/Servidor.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	create_buttons(5, 5)
	pass

func create_buttons(rows, columns):
	var b
	for i in range(0, rows):
		for j in range(0, columns):
			var r = randi() % 3
			if r == 0:
				b = celu.instance()
			elif r == 1:
				b = pc.instance()
			elif r == 2:
				b = servi.instance()
			#l = Label.new()
			b.name = "but_tier" + str(j) + "_" + str(i)
			#l.name = "lab_tier" + str(j) + "_" + str(i)
			var x = 96 * j + x_offset #+ (randi() % 10 - 5)
			var y = 82 * i + y_offset #+ (randi() % 10 - 5)
			b.translate(Vector2(x, y))
			#b.add_child(l)
			add_child(b)

func last_hacked():
	get_node("but_tier" + str(last_coord.y) + "_" + str(last_coord.x)).infect()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

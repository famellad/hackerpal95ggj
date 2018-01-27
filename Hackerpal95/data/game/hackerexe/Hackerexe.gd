extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var last_coord = Vector2(0, 0)

var challenge_open = false

var x_offset = 56 + 96
var y_offset = 80

var celu = preload("res://data/game/hackerexe/Celu.tscn")
var pc = preload("res://data/game/hackerexe/PC.tscn")
var servi = preload("res://data/game/hackerexe/Servidor.tscn")
var localhost = preload("res://data/game/hackerexe/Localhost.tscn")
var sbasa = preload("res://data/game/hackerexe/Basa.tscn")

var masher = preload("res://data/game/hackerexe/desafios/masher/Masher.tscn")
var lights_out = preload("res://data/game/hackerexe/desafios/lights_out/Light_Panel.tscn")
var strings = preload("res://data/game/hackerexe/desafios/strings/Strings.tscn")

var desktop

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	create_buttons(5, 5)
	pass

func create_buttons(rows, columns):
	var local = localhost.instance()
	local.name = "localhost"
	var local_x = x_offset - 96
	var local_y = 82 * 2 + y_offset
	local.translate(Vector2(local_x, local_y))
	add_child(local)
	
	var basa = sbasa.instance()
	basa.name = "basa"
	basa.coords = Vector2(100, 100)
	basa.hackerexe = self
	local_x = 96 * 5 + x_offset
	basa.translate(Vector2(local_x, local_y))
	add_child(basa)
	
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
			b.coords = Vector2(i, j)
			b.hackerexe = self
			#l.name = "lab_tier" + str(j) + "_" + str(i)
			var x = 96 * j + x_offset #+ (randi() % 10 - 5)
			var y = 82 * i + y_offset #+ (randi() % 10 - 5)
			b.translate(Vector2(x, y))
			#b.add_child(l)
			add_child(b)

func set_desktop(object):
	desktop = object

func last_hacked():
	challenge_open = false
	if last_coord.y == 100:
		return
	get_node("but_tier" + str(last_coord.y) + "_" + str(last_coord.x)).infect()
	
func open_challenge(diff):
	if challenge_open:
		return
	
	challenge_open = true
	
	var rand = randi() % 3
	
	var c
	
	if rand == 0:
		# Masher
		c = masher.instance()
		c.set_hackerexe(self)
		c.set_difficulty(diff)
		add_child(c)
	elif rand == 1:
		# Lights Out
		c = lights_out.instance()
		c.set_hackerexe(self)
		c.set_diff(diff)
		c.position.x = 400
		c.position.y = 200
		add_child(c)
	elif rand == 2:
		# Strings
		c = strings.instance()
		c.set_hackerexe(self)
		c.set_diff(diff)
		add_child(c)
		

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

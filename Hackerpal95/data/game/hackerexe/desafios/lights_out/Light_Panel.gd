extends Sprite

var size = 4
var pixel = 70
var move_x = 15
var move_y = 22 + 26
var win = false
var moves = []
var map = {3:"a cellphone", 4:"a PC", 6:"a server", 8:"BASA"}
var difficulty = "easy"
var barracarga = preload("res://data/game/barra_carga/BarraCarga.tscn")
var easy = load("res://data/game/hackerexe/desafios/lights_out/nivel_1.png")
var medium = load("res://data/game/hackerexe/desafios/lights_out/nivel_2.png")
var hard = load("res://data/game/hackerexe/desafios/lights_out/nivel_3.png")
var insane = load("res://data/game/hackerexe/desafios/lights_out/nivel_4.png")

var clicks = [preload("res://data/SFX/Click 1.wav"), preload("res://data/SFX/Click 2.wav"), preload("res://data/SFX/Click 3.wav")]

var barra
var hackerexe
onready var sound = get_node("sound")

func print_grid(grid):
	var temp = ""
	for line in grid:
		temp += str(line)+"\n"
	print(temp)

func set_hackerexe(obj):
	hackerexe = obj

func leave():
	pass

func set_diff(diff):
	var sprite = get_node(".")
	difficulty = diff
	if diff == "easy":
		size = 3
		sprite.set_offset(Vector2(140, 148))
		sprite.set_texture(easy)
	elif diff == "medium":
		size = 4
		sprite.set_offset(Vector2(166, 174))
		sprite.set_texture(medium)
	elif diff == "hard":
		size = 5
		sprite.set_offset(Vector2(206, 214))
		sprite.set_texture(hard)
	elif diff == "insane":
		size = 6
		sprite.set_offset(Vector2(246, 254))
		sprite.set_texture(insane)
	create_lights()
	light_up()

func create_lights():
	if size == 3:
		pixel = 80
	else:
		pixel = 70
	# var barra = get_node("BarraCarga")
	# barra.scale.x = size*pixel/240.0
	
	for i in range(1, size+1):
		for j in range(size):
			var button = TextureButton.new()
			button.name = "Button"+str(i+size*j)
			button.margin_left = pixel*(i-1) + 10 + move_x
			button.margin_right = pixel*i - 10 + move_x
			button.margin_top = pixel*j + 10 + move_y
			button.margin_bottom = pixel*(j+1) - 10 + move_y
			button.toggle_mode = true
			button.pressed = true
			button.texture_normal = load("res://data/game/hackerexe/desafios/lights_out/Candado2/candado2cerrado.png")
			button.texture_pressed = load("res://data/game/hackerexe/desafios/lights_out/Candado2/candado2abierto.png") 
			add_child(button)

func light_up():
	randomize()
	var n = -1
	var i = 0
	var l = range(1, pow(size, 2)+1)
	while i < size:
		# print(l)
		n = randi()%len(l)
		if moves.find(l[n]) == -1:
			light(l[n], true)
			i += 1
			l.erase(l[n])
	
	for i in range(1, pow(size, 2)+1):
		var button = get_node("Button"+str(i))
		button.connect("pressed", self, "light", [i, false]) 

func light(n, action):
	var button = get_node("Button"+str(n))
	
	if moves.find(n) != -1:
		moves.erase(n)
	else:
		moves.append(n)
	moves.sort()

	if action:
		button.pressed = not button.pressed
	elif not sound.playing:
		randomize()
		sound.stream = clicks[randi()%3]
		sound.play(0)
	if n%size != 0:
		button = get_node("Button"+str(n+1))
		button.pressed = not button.pressed
	if n%size != 1:
		button = get_node("Button"+str(n-1))
		button.pressed = not button.pressed
	if n < pow(size,2)-size+1:
		button = get_node("Button"+str(n+size))
		button.pressed = not button.pressed
	if n > size:
		button = get_node("Button"+str(n-size))
		button.pressed = not button.pressed
	
	var count = 0
	var temp = true
	for i in range(1, size+1):
		for j in range(size):
			button = get_node("Button"+str(i+size*j))
			if not button.pressed:
				temp = false
			else:
				count += 1

	if not action:
		barra.set_level(float(count)/pow(size, 2))

	if temp and not action:
		win = true
		hackerexe.last_hacked()
		get_node(".").queue_free()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	barra = barracarga.instance()
	barra.name = "BarraCarga"
	barra.position.y = 26
	add_child(barra) 

func _on_sound_finished():
	sound.stop()

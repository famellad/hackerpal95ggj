extends Sprite

var size = 6
var pixel = 80
var move_x = 0
var move_y = 42
var win = false
var moves = []
var map = {3:"a cellphone", 4:"a PC", 6:"a server", 8:"BASA"}
var difficulty = "easy"

var hackerexe

func print_grid(grid):
	var temp = ""
	for line in grid:
		temp += str(line)+"\n"
	print(temp)

func set_hackerexe(obj):
	hackerexe = obj

func leave():
	var popup = PopupPanel.new()
	popup.popup_centered()
	popup.margin_top = pixel
	popup.margin_bottom = pixel + 300
	popup.margin_left = pixel
	popup.margin_right = pixel + 400
	popup.visible = true
	add_child(popup)
	var text = Label.new()
	popup.add_child(text)
	text.margin_top = 100
	text.margin_left = 50
	text.align = 1
	if win:
		text.text = "You've hacked " + map[size]
		#hackerexe.last_hacked()
	else:
		text.text = "You've been caught"

func set_diff(diff):
	difficulty = diff
	if diff == "easy":
		size = 3
	elif diff == "medium":
		size = 4
	elif diff == "hard":
		size = 6
	elif diff == "insane":
		size = 8
	create_lights()
	light_up()

func create_lights():
	if size == 3:
		pixel = 90
	else:
		pixel = 80
	var sprite = get_node(".")
	#sprite.margin_right = size*pixel + move_x
	#sprite.margin_bottom = size*pixel + move_y
	
	# var barra = get_node("BarraCarga")
	# barra.scale.x = size*pixel/240.0
	
	for i in range(1, size+1):
		for j in range(size):
			var button = TextureButton.new()
			button.name = "Button"+str(i+size*j)
			button.margin_left = pixel*(i-1) + 2 + move_x
			button.margin_right = pixel*i - 2 + move_x
			button.margin_top = pixel*j + 2 + move_y
			button.margin_bottom = pixel*(j+1) - 2 + move_y
			button.toggle_mode = true
			button.pressed = true
			button.texture_normal = load("res://data/game/Candado2/candado2cerrado.png")
			button.texture_pressed = load("res://data/game/Candado2/candado2abierto.png") 
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

func light(n, action):
	var barra = get_node("BarraCarga")
	var button = get_node("Button"+str(n))
	# print(n, " ", moves.find(n))
	
	if moves.find(n) != -1:
		moves.erase(n)
	else:
		moves.append(n)
	moves.sort()
	print(moves)
	if action:
		button.pressed = not button.pressed
	if n%size != 0:
		button = get_node("Button"+str(n+1))
		# print(n+1, button.pressed)
		button.pressed = not button.pressed
	if n%size != 1:
		button = get_node("Button"+str(n-1))
		# print(n-1, button.pressed)
		button.pressed = not button.pressed
	if n < pow(size,2)-size+1:
		button = get_node("Button"+str(n+size))
		# print(n+size, button.pressed)
		button.pressed = not button.pressed
	if n > size:
		button = get_node("Button"+str(n-size))
		# print(n-size, button.pressed)
		button.pressed = not button.pressed
	
	# var grid = []
	var count = 0
	var temp = true
	for i in range(1, size+1):
		# var line = []
		for j in range(size):
			button = get_node("Button"+str(i+size*j))
			# line.append(button.pressed)
			if not button.pressed:
				temp = false
			else:
				count += 1
		# grid.append(line)
	# print_grid(grid)

	barra.set_level(float(count)/pow(size, 2))
	# print(count)

	if temp and not action:
		win = true
		leave()
	#print("Win: ", win)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	create_lights()
	
	light_up()
	
	for i in range(1, pow(size, 2)+1):
		var button = get_node("Button"+str(i))
		button.connect("pressed", self, "light", [i, false]) 
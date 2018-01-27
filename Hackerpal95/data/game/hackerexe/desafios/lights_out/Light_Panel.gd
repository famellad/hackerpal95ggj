extends Panel

var size = 3
var pixel = 90
var move_x = 0
var move_y = 22
var win = false
var moves = []
var map = {3:"un computador", 5:"un cybercafe", 7:"un servidor", 9:"la NASA"}
var difficulty = "easy"
var style = StyleBoxFlat.new()

signal succesful_hack

func print_grid(grid):
	var temp = ""
	for line in grid:
		temp += str(line)+"\n"
	print(temp)

func leave():
	var popup = PopupPanel.new()
	popup.popup_centered()
	popup.margin_top = pixel
	popup.margin_bottom = pixel + 300
	popup.margin_left = pixel
	popup.margin_right = pixel + 400
	popup.visible = true
	popup.add_stylebox_override("popup", style)
	add_child(popup)
	var text = Label.new()
	popup.add_child(text)
	text.margin_top = 100
	text.margin_left = 50
	text.align = 1
	if win:
		text.text = "Has hackeado " + map[size]
		emit_signal("succesful_hack", difficulty, "lights_out")
	else:
		text.text = "Te han atrapado"

func set_diff(diff):
	difficulty = diff
	if diff == "easy":
		size = 3
	elif diff == "medium":
		size = 5
	elif diff == "hard":
		size = 7
	elif diff == "insane":
		size = 9
	create_lights()
	light_up()

func create_lights():
	var panel = get_node(".")
	panel.margin_right = size*pixel + move_x
	panel.margin_bottom = size*pixel + move_y
	
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
	for i in range(size*2):
		light(randi()%int(pow(size, 2)) + 1, true)

func light(n, action):
	var barra = get_node("BarraCarga")
	var button = get_node("Button"+str(n))
	#print(n)
	if n in moves:
		moves.remove(n)
	else:
		moves.append(n)
	moves.sort()
	# print(moves)
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
	add_stylebox_override("panel", style)
	style.set_bg_color(Color(0.6, 0.6, 0.6))
	create_lights()
	
	light_up()
	
	for i in range(1, pow(size, 2)+1):
		var button = get_node("Button"+str(i))
		button.connect("pressed", self, "light", [i, false]) 
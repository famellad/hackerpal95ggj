extends Panel

var size = 3
var pixel = 100
var move_x = 0
var move_y = 0
var win =  false

func print_grid(grid):
	var temp = ""
	for line in grid:
		temp += str(line)+"\n"
	print(temp)

func set_diff(diff):
	if diff == "easy":
		size = 3
	elif diff == "medium":
		size = 5
	elif diff == "hard":
		size = 7
	elif diff == "insane":
		size = 9
	create_lights()

func create_lights():
	var panel = get_node(".")
	panel.margin_right = size*pixel + move_x
	panel.margin_bottom = size*pixel + move_y
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
			add_child(button)

func light_up():
	for i in range(size*3):
		light(randi()%int(pow(size, 2)) + 1, true)

func light(n, action):
	var button = get_node("Button"+str(n))
	print(n," ", button.pressed)
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
	
	var grid = []
	var temp = true
	for i in range(1, size+1):
		var line = []
		for j in range(size):
			button = get_node("Button"+str(i+size*j))
			line.append(button.pressed)
			if not button.pressed:
				temp = false
		grid.append(line)
	print_grid(grid)

	if temp:
		win = true
	
	print("Win: ", win)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	create_lights()
	
	light_up()
	
	for i in range(1, pow(size, 2)+1):
		var button = get_node("Button"+str(i))
		button.connect("pressed", self, "light", [i, false]) 
	


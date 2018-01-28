extends Line2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var route = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	default_color = Color(0.8, 0.1, 0.05)
	width = 6
	
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	_draw()
	pass
#func draw_line():
#	draw_line(Vector2(0,0), Vector2(50, 50), Color(0.8, 0.1, 0.05), 4)

func add_route_node (vec):
	#route.append(vec)
	#print( route )
	add_point(vec)

func _draw():
	#draw_line(Vector2(0, 0), Vector2(400, 400), Color(0,0,0), 7)
	#print (route.size())
	#if route.size() >= 2:
	#for i in range(0, route.size() - 1):
	#	draw_line(Vector2(0, 0), Vector2(400, 400), Color(0,0,0), 7)
	#	print(Vector2(route[i][0], route[i][1]))
	#	print(Vector2(route[i+1][0], route[i+1][1]))
	#	draw_line(Vector2(route[i][0], route[i][1]), Vector2(route[i+1][0], route[i+1][1]), Color(0.8, 0.1, 0.05), 4)
extends Node2D

var level = 0
var sprite_texture = preload("res://data/game/barra_carga/rectangulo.png")

func _ready():
	var s
	for i in range(0, 20):
		s = Sprite.new()
		s.hide()
		s.set_name("box_" + str(i))
		s.translate(Vector2(13 * i, 0))
		s.set_texture(sprite_texture)
		s.centered = false
		add_child(s)

func set_level(new_level):
	if new_level > 1:
		new_level = 1
	
	level = new_level
	new_level = ceil(20 * new_level)
	
	for i in range(0, new_level):
		get_node("box_" + str(i)).show()

#func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
#	set_level(level + delta)

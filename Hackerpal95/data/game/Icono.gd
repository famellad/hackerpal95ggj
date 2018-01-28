extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var selected_texture = preload("res://data/game/iconoseleccionado.png")
var normal_texture = preload("res://data/game/icono.png")
var hackerexe = preload("res://data/game/hackerexe/Hackerexe.tscn")

var hhp

func _ready():
	# Called every time the node is added to the scene.
	hhp = get_parent().get_node("HackerHP")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Icono_button_down():
	icon = selected_texture

func _on_Icono_button_up():
	var h = hackerexe.instance()
	h.name = "Hackerexe"
	h.translate(Vector2(154, 113))
	h.desktop = get_parent().get_parent()
	
	self.disabled = true
	
	get_parent().add_child(h)
	icon = normal_texture
	
	hhp.set_time(40)
	hhp.show()
	


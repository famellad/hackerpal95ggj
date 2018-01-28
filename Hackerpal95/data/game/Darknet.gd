extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var modem = preload("res://data/SFX/Modem.wav")

onready var sound = get_node("sound")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	sound.set_stream(modem)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Darknet_pressed():
	sound.play(0)

func _on_sound_finished():
	sound.stop()

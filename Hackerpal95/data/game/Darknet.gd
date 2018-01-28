extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var modem = preload("res://data/SFX/Modem.wav")

var dl = preload("res://data/game/victoria/Downloader.tscn")

var desk

onready var sound = get_node("sound")

func _ready():
	desk = get_parent().get_parent()
	sound.set_stream(modem)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Darknet_pressed():
	sound.play(0)
	
	if desk.already_won:
		var d = dl.instance()
		desk.add_child(d)

func _on_sound_finished():
	sound.stop()

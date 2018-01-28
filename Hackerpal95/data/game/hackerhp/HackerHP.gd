extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rem_time = 10
var max_time = 80

var desktop

var time_alert = preload("res://data/SFX/Alerta De tiempo.wav")

onready var sound = get_node("sound")

func _ready():
	sound.set_stream(time_alert)
	#set_process_input(true)
	$BarraCarga.set_level(1)

func add_time( amount ):
	rem_time += amount

func set_time( amount ):
	rem_time = amount
	
func lose():
	desktop.lose()
	hide()#queue_free()
	
func _process(delta):
	if self.visible:
		rem_time -= delta
		$BarraCarga.set_level(rem_time / max_time)
		if rem_time > max_time:
			rem_time = max_time
		if rem_time <= 10 and not sound.playing:
			sound.play()
		if rem_time < 0:
			rem_time = 0
			lose()

func _on_sound_finished():
	sound.stop()

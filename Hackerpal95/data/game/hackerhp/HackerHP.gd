extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rem_time = 40
var max_time = 80

var desktop

func _ready():
	#set_process_input(true)
	$BarraCarga.set_level(1)

func add_time( amount ):
	pass
	
func _process(delta):
	rem_time -= delta
	$BarraCarga.set_level(rem_time / max_time)
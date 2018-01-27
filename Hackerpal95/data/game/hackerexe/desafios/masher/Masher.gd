extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var diff = "easy"
var mash_level = 0
var mash_drain = 20
var mash_threshold = 0
var possible_scancodes = [65, 57, 72, 75]
var diff_scancodes = []
var mash_key_scancode = 75 # 75 es k

var hackerexe

var draining = true

func _ready():
	set_process_input(true)
	set_difficulty("insane")

func set_hackerexe(object):
	hackerexe = object

func set_difficulty(new_diff):
	diff = new_diff
	if diff == "easy":
		mash_threshold = 100
		mash_drain = 15
		pick_scancodes(1)
	elif diff == "medium":
		mash_threshold = 150
		mash_drain = 25
		pick_scancodes(2)
	elif diff == "hard":
		mash_threshold = 200
		mash_drain = 30
		pick_scancodes(3)
	elif diff == "insane":
		mash_threshold = 250
		mash_drain = 40
		pick_scancodes(4)

func pick_scancodes(number):
	diff_scancodes = possible_scancodes
	
	if number == 4:
		return

	for i in range(0, number):
		diff_scancodes.pop_front()

func victory():
	mash_level = mash_threshold
	draining = false

func _process(delta):
	if randf() < 0.01:
		mash_key_scancode = possible_scancodes[randi() % (possible_scancodes.size())]
	
	if mash_level > mash_threshold:
		victory()
	
	if draining:
		mash_level -= mash_drain * delta
	
	if mash_level < 0:
		mash_level = 0
	
	var mash_string = ""
	
	if mash_key_scancode == 65:
		mash_string = "A"
	elif mash_key_scancode == 57:
		mash_string = "C"
	elif mash_key_scancode == 72:
		mash_string = "H"
	elif mash_key_scancode == 75:
		mash_string = "K"
	
	# DEBUG
	$debug.text = "MASH LEVEL : " + mash_string + " : " + str(mash_level)
	
func _input(event):
	if (event is InputEventKey):
		if event.scancode == mash_key_scancode && !event.echo && event.pressed: # Si es la tecla, si acaba de apretarla y si la esta apretando (no soltando)
			mash_level += 10;
		#$debug.text = str(event.scancode)
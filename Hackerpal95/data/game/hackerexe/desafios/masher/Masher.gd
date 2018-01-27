extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mash_level = 0
var mash_drain = 20
var mash_threshold = 0
var mash_key_scancode = 75 # 75 es k

var draining = true

func _ready():
	set_process_input(true)
	set_difficulty("insane")

func set_difficulty(diff):
	if diff == "easy":
		mash_threshold = 100
		mash_drain = 15
	elif diff == "medium":
		mash_threshold = 150
		mash_drain = 25
	elif diff == "hard":
		mash_threshold = 200
		mash_drain = 30
	elif diff == "insane":
		mash_threshold = 250
		mash_drain = 40

func victory():
	mash_level = mash_threshold
	draining = false

func _process(delta):
	if mash_level > mash_threshold:
		victory()
	
	if draining:
		mash_level -= mash_drain * delta
	
	if mash_level < 0:
		mash_level = 0
	
	# DEBUG
	$debug.text = "MASH LEVEL : " + str(mash_level)
	
func _input(event):
	if (event is InputEventKey):
		if event.scancode == mash_key_scancode && !event.echo && event.pressed: # Si es la tecla, si acaba de apretarla y si la esta apretando (no soltando)
			mash_level += 10;
#$debug.text = str(event.scancode)
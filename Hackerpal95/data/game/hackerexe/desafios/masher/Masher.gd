extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var diff = "easy"
var mash_level = 0
var mash_drain = 20
var mash_threshold = 0
var possible_scancodes = [KEY_A, KEY_C, KEY_H, KEY_K]
var diff_scancodes = []
var mash_key_scancode = 75 # 75 es k

var hack_visible = true
var hack_timer = 0.5

var hackerexe
var sfx_node

var draining = true

var tecleo = preload("res://data/SFX/Tecleo.wav")

var lines = []

func _ready():
	sfx_node = get_node("Ventana/SFX/Sound")
	sfx_node.set_stream( tecleo )
	set_process_input(true)
	#set_difficulty("insane")
	get_lines()
	$Ventana/Code.scroll_following = true

func get_lines():
	var file = File.new()
	file.open("res://data/game/hackerexe/desafios/masher/code.txt", File.READ)
	while not file.eof_reached():
		lines.append(file.get_line())

func set_hackerexe(object):
	hackerexe = object

func set_difficulty(new_diff):
	diff = new_diff
	if diff == "easy":
		mash_threshold = 100
		mash_drain = 14
		#pick_scancodes(4)
	elif diff == "medium":
		mash_threshold = 150
		mash_drain = 23
		#pick_scancodes(4)
	elif diff == "hard":
		mash_threshold = 200
		mash_drain = 28
		#pick_scancodes(3)
	elif diff == "insane":
		mash_threshold = 300
		mash_drain = 50
		#pick_scancodes(4)

func pick_scancodes(number):
	diff_scancodes = possible_scancodes
	
	if number == 4:
		return

	for i in range(0, number):
		diff_scancodes.pop_front()

func victory():
	sfx_node.stop()
	mash_level = mash_threshold
	draining = false
	hackerexe.last_hacked()
	queue_free()

func _process(delta):
	if randf() < 0.5:
		mash_key_scancode = possible_scancodes[randi() % (possible_scancodes.size())]
	
	if mash_level > mash_threshold:
		victory()
	
	if draining:
		mash_level -= mash_drain * delta
	
	if mash_level < 0:
		mash_level = 0
	
	var mash_string = ""
	
	if mash_key_scancode == KEY_A:
		mash_string = "A"
	elif mash_key_scancode == KEY_C:
		mash_string = "C"
	elif mash_key_scancode == KEY_H:
		mash_string = "H"
	elif mash_key_scancode == KEY_K:
		mash_string = "K"
	
	$Ventana/BarraCarga.set_level(mash_level/mash_threshold)
	
	hack_timer -= delta
	if hack_timer < 0:
		hack_timer = 0.5
		if hack_visible:
			hack_visible = false
			$Ventana/MashMessage2.hide()
		else:
			hack_visible = true
			$Ventana/MashMessage2.show()
	
	# DEBUG
	#$debug.text = "MASH LEVEL : " + mash_string + " : " + str(mash_level)

func successful_mash():
	mash_level += 10
	$Ventana/Code.text += "\n" + choose_random_line()
	if not sfx_node.playing:
		sfx_node.play(0)
	#$Ventana/Code.scroll_following

func choose_random_line():
	return lines[randi() % lines.size()] 

func _input(event):
	if (event is InputEventKey):
		if event.scancode == mash_key_scancode && !event.echo && event.pressed: # Si es la tecla, si acaba de apretarla y si la esta apretando (no soltando)
			successful_mash()
		#$debug.text = str(event.scancode)

func _on_Sound_finished():
	sfx_node.stop()

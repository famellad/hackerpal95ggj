extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var last_coord = Vector2(0, 0)
var last_diff = ""

var challenge_open = false

var x_offset = 56 + 96
var y_offset = 80

var celu = preload("res://data/game/hackerexe/Celu.tscn")
var pc = preload("res://data/game/hackerexe/PC.tscn")
var servi = preload("res://data/game/hackerexe/Servidor.tscn")
var localhost = preload("res://data/game/hackerexe/Localhost.tscn")
var sbasa = preload("res://data/game/hackerexe/Basa.tscn")

var masher = preload("res://data/game/hackerexe/desafios/masher/Masher.tscn")
var lights_out = preload("res://data/game/hackerexe/desafios/lights_out/Light_Panel.tscn")
var strings = preload("res://data/game/hackerexe/desafios/strings/Strings.tscn")
var downloader = preload("res://data/game/victoria/Downloader.tscn")

var menu_select = preload("res://data/SFX/Menu Select.wav")
var win_sound = preload("res://data/SFX/Windows 95 Startup Remake.wav")
var exito = preload("res://data/SFX/Hackeo Exitoso.wav")
var startup = preload("res://data/SFX/Computer startup.wav")

var ini_lvl_1 = preload("res://data/music/Inicio Level 1 - menu.wav")
var ini_lvl_2 = preload("res://data/music/Inicio Level 2.wav")
var ini_lvl_3 = preload("res://data/music/Inicio Level 3.wav")
var ini_lvl_4 = preload("res://data/music/Inicio Level 4.wav")
var ini_lvl_5 = preload("res://data/music/Inicio Level 5.wav")

var lvl_1 = preload("res://data/music/Level 1 - menu.wav")
var lvl_2 = preload("res://data/music/Level 2.wav")
var lvl_3 = preload("res://data/music/Level 3.wav")
var lvl_4 = preload("res://data/music/Level 4.wav")
var lvl_5 = preload("res://data/music/Level 5.wav")

onready var sound = get_node("sound")
onready var music = get_node("music")

var tier = 0
var tier_beaten = 0

var desktop
var hhp

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	sound.set_stream(exito)
	create_buttons(5, 5)
	unlock_tier0()
	$Warnings.hide()
	pass

func create_buttons(rows, columns):
	var local = localhost.instance()
	local.name = "localhost"
	var local_x = x_offset - 96
	var local_y = 82 * 2 + y_offset
	local.translate(Vector2(local_x, local_y))
	$Lines.add_route_node(Vector2(local_x, local_y))
	add_child(local)

	var basa = sbasa.instance()
	basa.name = "basa"
	basa.coords = Vector2(100, 100)
	basa.hackerexe = self
	local_x = 96 * 5 + x_offset
	basa.translate(Vector2(local_x, local_y))
	add_child(basa)

	var b
	for j in range(0, rows):
		for i in range(0, columns):
			var r = randi() % 3
			if r == 0:
				b = celu.instance()
			elif r == 1:
				b = pc.instance()
			elif r == 2:
				b = servi.instance()
			b.name = "but_tier" + str(j) + "_" + str(i)
			b.coords = Vector2(i, j)
			b.hackerexe = self
			var x = 96 * j + x_offset #+ (randi() % 10 - 5)
			var y = 82 * i + y_offset #+ (randi() % 10 - 5)
			b.translate(Vector2(x, y))
			add_child(b)
			yield(get_tree().create_timer(0.03), "timeout")

func set_desktop(object):
	desktop = object

# Desbloquea el tier mas bajo, para comenzar a jugar
func unlock_tier0():
	sound.set_stream(startup)
	sound.play(0)
	yield(get_tree().create_timer(1.5), "timeout")
	for i in range(0, 5):
		get_node("but_tier" + str(0) + "_" + str(i)).activate()

# Desbloquea el siguiente tier
func tier_up():
	tier += 1
	music.stop()
	
	var unlocks
	
	match last_diff:
		"easy"   : unlocks = 1
		"medium" : unlocks = 2
		"hard"   : unlocks = 3
	
	
	for i in range(0, 5):
		get_node("but_tier" + str(tier - 1) + "_" + str(i)).activate()
	
	var rand = randi() % 5
	
	var active = true
	
	for i in range(unlocks):
		while true:
			rand = randi() % 5
			var node = get_node("but_tier" + str(tier) + "_" + str(rand))
			active = node.active
			if active:
				continue
			else:
				node.activate()
				break
		
	
	new_title()

func ultimate_victory():
	var d = downloader.instance()
	d.global_transform[2] = Vector2(356, 276)
	add_child(d)
	desktop.hide_hhp()
	sound.set_stream(win_sound)
	music.stop()
	tier = 6
	sound.play(0)
	
	yield(get_tree().create_timer(10.0), "timeout")
	desktop.win()

func last_hacked():
	sound.set_stream(exito)
	sound.play(0)
	challenge_open = false

	add_challenge_time()

	if last_coord.y == 100:
		ultimate_victory()
		$Lines.add_route_node(Vector2(96 * 5 + x_offset, 82 * 2 + y_offset))
		tier = 6
		return

	var inf_node = get_node("but_tier" + str(last_coord.y) + "_" + str(last_coord.x))

	if last_coord.y == 4:
		$basa.activate()
		tier += 1
		new_title()
		$Lines.add_route_node(inf_node.get_transform()[2])
		music.stop()
	elif last_coord.y == tier:
		tier_up()
		$Lines.add_route_node(inf_node.get_transform()[2])

	inf_node.infect()

func add_challenge_time():
	match last_diff:
		"easy" : desktop.add_time(5)
		"medium" : desktop.add_time(8)
		"hard" : desktop.add_time(14)

func open_challenge(diff):
	if challenge_open:
		return
	
	sound.set_stream(menu_select)
	sound.play(0)

	challenge_open = true

	last_diff = diff

	var rand = randi() % 3

	var c

	if rand == 0:
		# Masher
		c = masher.instance()
		c.set_hackerexe(self)
		c.set_difficulty(diff)
		add_child(c)
	elif rand == 1:
		# Lights Out
		c = lights_out.instance()
		c.set_hackerexe(self)
		c.set_diff(diff)
		add_child(c)
	elif rand == 2:
		# Strings
		c = strings.instance()
		c.set_hackerexe(self)
		c.set_difficulty(diff)
		add_child(c)

func new_title():
	var title = "Hackerpal '95 -- Hacking Level: "
	var newLevel = ""
	match tier:
		0 : newLevel = "WEAK"
		1 : newLevel = "LAUGHABLE"
		2 : newLevel = "MEH"
		3 : newLevel = "RESPECTABLE"
		4 : newLevel = "RADICAL"
		5 : newLevel = " I N T E N S E"

	$Label.text = title + newLevel
	
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if not music.playing:
		if music.stream == ini_lvl_1:
			music.set_stream(lvl_1)
			music.play(0)
		elif music.stream == ini_lvl_2:
			music.set_stream(lvl_2)
			music.play(0)
		elif music.stream == ini_lvl_3:
			music.set_stream(lvl_3)
			music.play(0)
		elif music.stream == ini_lvl_4:
			music.set_stream(lvl_4)
			music.play(0)
		elif music.stream == ini_lvl_5:
			music.set_stream(lvl_5)
			music.play(0)
		elif tier == 0 or tier == 1:
			music.set_stream(ini_lvl_1)
			music.play(0)
		elif tier == 2:
			music.set_stream(ini_lvl_2)
			music.play(0)
		elif tier == 3:
			music.set_stream(ini_lvl_3)
			music.play(0)
		elif tier == 4:
			music.set_stream(ini_lvl_4)
			music.play(0)
		elif tier == 5:
			music.set_stream(ini_lvl_5)
			music.play(0)
	elif tier == 6:
		music.stop()
		
	if tier == 5:
		$Warnings.show()
	else:
		$Warnings.hide()


func _on_sound_finished():
	sound.stop()

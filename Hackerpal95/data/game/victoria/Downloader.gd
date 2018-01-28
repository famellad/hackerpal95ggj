extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var level = 0
var new_shitpost = 0
var next_z = 0
var draw = [false, false, false, false, false, false]

var timeout = 10
var timer = 0

func _ready():
	randomize()
	$HelpWindow.read_from_file("Chili.txt")
	$FakeLanding.hide()
	$FreePalmPilot.hide()
	$CyberSecurity.hide()
	$TrueShape.hide()
	$HelpWindow.hide()
	$BSB.hide()
	$Window.z_index = 100


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	level += delta / 6
	new_shitpost += delta / 6
	
	$Window/BarraCarga.set_level(level)
	
	if new_shitpost >= 0.2 && check_windows():
		#print("hit " + str(new_shitpost))
		new_shitpost = 0
		var drawn = false
		
		while not drawn:
			var r = randi() % draw.size()
			drawn = select_shitpost(r)
			
	timer += delta
	if timer > timeout:
		queue_free()
	
func check_windows():
	for i in range(draw.size()):
		if not draw[i]:
			return true
	return false
	
func select_shitpost(num):
	if draw[num]:
		return false
	
	match num:
		0:
			$FakeLanding.show()
			$FakeLanding.z_index = next_z
		1:
			$FreePalmPilot.show()
			$FreePalmPilot.z_index = next_z
		2:
			$CyberSecurity.show()
			$CyberSecurity.z_index = next_z
		3:
			$TrueShape.show()
			$TrueShape.z_index = next_z
		4:
			$HelpWindow.show()
			$HelpWindow.z_index = next_z
		5:
			$BSB.show()
			$BSB.z_index = next_z
	
	next_z += 1
	
	#hide()
	#show()
	
	draw[num] = true
	return true
	
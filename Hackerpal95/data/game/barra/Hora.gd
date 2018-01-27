extends Label

# class member variables go here, for example:
# var a = 2
var time_dict = OS.get_time()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	time_dict = OS.get_time()
	var hh = time_dict.hour;
	var m = time_dict.minute;
	var s = time_dict.second;
	
	var mm = ""
	var ss = ""
	
	if m < 10:
		mm = str(0) + str(m)
	else:
		mm = str(m)
	
	if s < 10:
		ss = str(0) + str(s)
	else:
		ss = str(s)
	
	text = str(hh) + ":" + str(mm) + ":" + str(ss)

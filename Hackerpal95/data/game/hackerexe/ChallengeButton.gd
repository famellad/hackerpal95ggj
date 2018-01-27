extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ChallengeButton_button_up():
	if get_parent().active:
		get_parent().hackerexe.last_coord = get_parent().coords
		get_parent().hackerexe.open_challenge(get_parent().diff)
	else:
		# Mostrar un error
		pass

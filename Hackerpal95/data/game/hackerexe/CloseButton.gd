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


func _on_CloseButton_button_up():
	get_parent().get_parent().desktop.get_node("Centerer/HackerHP").hide()
	get_parent().get_parent().desktop.enable_button()
	get_parent().get_parent().queue_free()

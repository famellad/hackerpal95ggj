extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
    if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed \
	:
        get_parent().get_parent().hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

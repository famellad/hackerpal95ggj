extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var desk

func _ready():
	desk = get_parent().get_parent()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_WallpaperChange_button_up():
	desk.random_wallpaper()

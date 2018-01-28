extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func read_from_file( filename ):
	var file = File.new()
	file.open("res://data/game/help/" + filename, File.READ)
	$Window/Title.text = filename
	while not file.eof_reached():
		$Window/Contents.text += "\n" + file.get_line()
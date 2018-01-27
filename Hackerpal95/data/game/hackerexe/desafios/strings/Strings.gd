extends Node2D
var time = 5
var word

func _ready():
  randomize()
  word = and_word(get_words('easy'))
  
  
func _input(event):
  if (event is InputEventKey and !event.echo and event.pressed):
    var pressedChar = OS.get_scancode_string(event.scancode).to_lower()
    $Panel/CenterContainer/Typetext.text += pressedChar
  
func _process(delta):
#  # Called every frame. Delta is time since last frame.
#  # Update game loa
  #time -= delta
  #$Panel/CenterContainer/Label.text = str( "%10.1f" % time)
  
  #if time < 0:
  #  hide()
  pass
  
func get_words(diff):
  var file = File.new()
  file.open("res://data/game/hackerexe/desafios/strings/"+diff+".txt", File.READ)
  var lines = []
  while not file.eof_reached():
    lines.append(file.get_line())
  return lines

func rand_word(array):
  
  var word = array[randi() % array.size()]
  return word
    


extends Node2D
##var time = 5
var word
var textnode
var diffarray = ['easy','medium','hard','insane']

var diff = 'easy' setget set_diff

func set_diff(newvalue):
    diff=newvalue

func _ready():
  randomize()
  ##set_diff(rand_word(diffarray))
  word = rand_word(get_words(diff)).to_upper()
  textnode = $Panel/CenterContainer/VBoxContainer/Typetext 
  textnode.text = word
  
func _input(event):
  if (event is InputEventKey and !event.echo and event.pressed):
    if(event.scancode >= 65 and event.scancode <= 90):
      #var pressedChar = str(event.scancode)
      var pressedChar = OS.get_scancode_string(event.scancode)
      #textnode.text += pressedChar
      if (word.begins_with(pressedChar)):
        word.erase(0,1)
        ##$debug.text += word
        textnode.text = word
        if(word ==''):
          textnode.text = 'SUCCESS!!'
          queue_free()
      else:
        textnode.text = 'Error!!!'
        ##queue_free()
      
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
    


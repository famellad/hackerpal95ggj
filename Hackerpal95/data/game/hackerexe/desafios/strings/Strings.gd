extends Node2D
var time = 5
var word
var textnode
var texttimer
var diffarray = ['easy','medium','hard','insane']
enum State {Infecting, Transmitted , Error}

var diff = 'easy' setget set_diff

var statedesafio

func set_diff(newvalue):
    diff=newvalue

func _ready():
  randomize()
  statedesafio = State.Infecting
  set_diff(rand_word(diffarray))
  word = rand_word(get_words(diff)).to_upper()
  
  match diff:
    'easy': time = 20
    'medium': time = 10
    'hard': time = 7
    'insane': time = 3
  
  textnode = $Panel/CenterContainer/VBoxContainer/Typetext 
  textnode.text = word
  texttimer = $Panel/Timer
  
func _input(event):
  if (event is InputEventKey and !event.echo and event.pressed and statedesafio == State.Infecting):
    if(event.scancode >= 65 and event.scancode <= 90):
      #var pressedChar = str(event.scancode)
      var pressedChar = OS.get_scancode_string(event.scancode)
      #textnode.text += pressedChar
      if (word.begins_with(pressedChar) and textnode.text != 'Error!!!'):
        word.erase(0,1)
        ##$debug.text += word
        textnode.text = word
        if(word ==''):
          textnode.text = 'TRANSMITTED!!'
          statedesafio = State.Transmitted
          yield(get_tree().create_timer(1.0), "timeout") 
          queue_free()
      else:
        texttimer.text = '0.0'
        textnode.text = 'Error!!!'
        statedesafio = State.Error
        yield(get_tree().create_timer(1.0), "timeout")
        queue_free()
      
func _process(delta):
#  # Called every frame. Delta is time since last frame.
#  # Update game loa
  if statedesafio == State.Infecting:
      time -= delta
      texttimer.text = str( "%10.1f" % time)
      
      if time <= 0.0:
        texttimer.text = '0'
        textnode.text = 'Error!!!'
        statedesafio == State.Error
        yield(get_tree().create_timer(1.0), "timeout")
        ## Aqui se deberia emitir una señal para el "NODO, computador" que es hackeado
        ## para que cambie su estado de virus transmitido
        queue_free()
  
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
    


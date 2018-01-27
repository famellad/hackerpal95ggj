extends KinematicBody2D

export (int) var speed
var velocity = Vector2()
var screen_size

func _ready():
  screen_size = get_viewport_rect().size

func _process(delta):

  velocity = Vector2()
  
  if Input.is_action_pressed("ui_right"):   
    velocity.x += 1
  if Input.is_action_pressed("ui_up"):
    velocity.y -= 1
  if Input.is_action_pressed("ui_left"):
    velocity.x -= 1
  if Input.is_action_pressed("ui_down"):
    velocity.y += 1
    
  if velocity.length() > 0:
    velocity = velocity.normalized() * speed
    
  position += velocity * delta
  position.x = clamp(position.x,0,screen_size.x)
  position.y = clamp(position.y,0,screen_size.y)



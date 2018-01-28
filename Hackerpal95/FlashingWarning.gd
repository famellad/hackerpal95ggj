extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var a_toggle_t
var a_toggle_m = 0.15
var fc = 0

var colors = [Color(1, 0, 0), Color(1, 1, 0)]

func _ready():
	a_toggle_t = a_toggle_m
	pass

func _process(delta):
	a_toggle_t -= delta
	if a_toggle_t < 0:
		a_toggle_t = a_toggle_m
		$Sprite.frame = ($Sprite.frame + 1) % 2

		
	if fc % 1 == 0:
		$Sprite.translate(Vector2(randf() * 1 - 0.5, randf() * 1 - 0.5))
	
	if fc % 24 == 0:
		$Sprite.transform[2] = Vector2(0, 0)
		#$Sprite.transform.y = 0
	
	fc += 1
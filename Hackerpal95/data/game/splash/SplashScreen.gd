extends Control

export (PackedScene) var next_scene

onready var anim_player = $AnimationPlayer
onready var vega_sound = $Vega

func _ready():
	# play animation
	anim_player.play("fade_in_out")


func _on_AnimationPlayer_animation_finished( anim_name ):
	print('cambio de escena')
	get_tree().change_scene('res://data/game/Menu.tscn')


#func _on_AnimationPlayer_animation_started( anim_name ):
#	vega_sound.play(0.0)
func play_Startup():
	vega_sound.play(0.0)

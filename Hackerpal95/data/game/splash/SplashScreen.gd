extends Control

export (PackedScene) var next_scene

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("fade_in_out")


func _on_AnimationPlayer_animation_finished( anim_name ):
	get_tree().change_scene('res://data/game/Menu.tscn')

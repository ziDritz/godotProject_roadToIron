class_name SceneTransitionManager
extends CanvasLayer

signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer 
@onready var main: Node = $".."


func _ready() -> void:
	visible = false 
	# Sinon, le layer est au dessus de tout et impossible 
	# d'intéragir avec les controle nodes d'autres states 
	# (ex, Buttons du Main Menu) 


func play_transition(transition_name: String):

	#visible = true
	animation_player.play(transition_name)
	await animation_player.animation_finished
	animation_finished.emit()
	await get_tree().process_frame # Cette ligne elle permet de pas avoir une frame dégeu entre deux animations
	$ColorRect.color.a = 0 # Reset ColorRect 
	#visible = false
	# J'ai enlevé les switch de visible 
	# et j'ai passé le mouse filter de color rect en ignore
	# J'ai pas trop compris mais en gros godot galère
	# quand on appelle deux animations à la suite et qu'on toggle 
	# la visibilité (en plus il y avait des signaux pour compliquer les choses

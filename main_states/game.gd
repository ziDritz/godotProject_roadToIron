class_name Game
extends Node


signal main_menu_requested
signal game_ended

enum GameLevel { ONE, TWO, THREE, BOSS }

var current_game_level: GameLevel
var is_game_paused: bool = false
var game_mode: bool
var level

@onready var game_ui: GameUI = $GameUI
@onready var spell_factory: SpellFactory = $SpellFactory 
@onready var turn_system: TurnSystem = $TurnSystem
@onready var scene_transition_player: SceneTransitionManager = $SceneTransitionPlayer



#func _ready() -> void:
	#print_tree()


func _input(event):
	if event.is_action_pressed("pause"):
		if is_game_paused == false:
			_set_pause(true)
			return
		elif is_game_paused == true:
			_set_pause(false)
			return


func start_game():
	_go_to_level(GameLevel.ONE)


func _go_to_level(game_level: GameLevel):
	pass
	
func _set_pause(_bool: bool):
	if _bool == true:
		level.process_mode = Node.PROCESS_MODE_DISABLED
		game_ui.set_pause(true)	
		is_game_paused = true
	
	if _bool == false:
		level.process_mode = Node.PROCESS_MODE_INHERIT
		game_ui.set_pause(false)	
		is_game_paused = false


func _on_space_shooter_level_game_over() -> void:
	game_ui.set_game_over()


func _on_space_shooter_level_level_cleared(_current_game_level) -> void:
	pass


func _on_game_ui_retry_requested() -> void:
	_go_to_level(current_game_level)


func _on_game_ui_main_menu_requested() -> void:
	main_menu_requested.emit()

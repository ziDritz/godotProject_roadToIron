extends Node

enum MainState { MAIN_MENU, PLAYING, PAUSED, GAME_OVER, ENDING }

const ENDING_SCENE = preload("res://main_states/ending.tscn")
const GAME_SCENE = preload("res://main_states/game.tscn")
const MAIN_MENU_SCENE = preload("res://main_states/main_menu.tscn")

var main_menu: MainMenu
var game: Game
var ending: Ending
var game_mode: bool = false

var current_state: MainState

@onready var scene_transition_player: SceneTransitionPlayer = $SceneTransitionPlayer


func _ready() -> void:
	set_state(MainState.MAIN_MENU)
	


func set_state(new_state):
	current_state = new_state
	match new_state:
		MainState.MAIN_MENU:
			_go_to_main_menu()
		MainState.PLAYING:
			_go_to_game()
		MainState.ENDING:
			_go_to_ending()


func _go_to_main_menu():
	if game != null: game.queue_free()
	if ending != null: ending.queue_free()
	
	main_menu = MAIN_MENU_SCENE.instantiate()
	main_menu.button_start_pressed.connect(_on_main_menu_button_start_pressed)
	main_menu.set_mode_requested.connect(_on_set_mode_requested)
	add_child(main_menu)
	
	
func _go_to_game():
	if main_menu != null:
		main_menu.animate_player_out()
	await get_tree().create_timer(2.0).timeout
	
	scene_transition_player.play_transition("animation_ressources/fade_out")
	await scene_transition_player.animation_finished
	
	
	# En théorie (mais vraiment je suis pas sûr)
	# On instancie le game avec le main menu pour éviter
	# qu'une frame saute entre les deux
	# J'ai mis le $SceneTransitionPlayer de main sur le layer 2
	# J'ai mis le $SceneTransitionPlayer de game sur le layer 1
	game = GAME_SCENE.instantiate()
	game.main_menu_requested.connect(_go_to_main_menu)
	game.game_ended.connect(_go_to_ending)
	game.game_mode = game_mode
	add_child(game)		
	game.start_game()		
	
	if main_menu != null: main_menu.queue_free()
	if ending != null: ending.queue_free()
	

	
func _go_to_ending():
		
	ending = ENDING_SCENE.instantiate()
	add_child(ending)
	MusicManager.play("musics", "ending", 3.0, true)
	SoundManager.play("SFXs", "ending")
	
	if main_menu != null: main_menu.queue_free()
	if game != null: game.queue_free()
	$SceneTransitionPlayer/ColorRect.color = Color.BLACK
	scene_transition_player.play_transition("animation_ressources/fade_in")


	await get_tree().create_timer(35.0).timeout
	scene_transition_player.play_transition("animation_ressources/fade_out")
	await scene_transition_player.animation_finished
	
	_go_to_main_menu()


func _on_main_menu_button_start_pressed() -> void:
	_go_to_game()
	
func _on_set_mode_requested(_bool: bool):
	game_mode = _bool
	

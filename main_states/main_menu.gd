class_name MainMenu
extends Control

signal button_start_pressed
signal set_mode_requested(bool)

@onready var button_v_box_container: VBoxContainer = $ButtonVBoxContainer
@onready var start_game_button: Button = $ButtonVBoxContainer/StartGameButton
@onready var options_button: Button = $ButtonVBoxContainer/OptionsButton
@onready var exit_button: Button = $ButtonVBoxContainer/ExitButton
@onready var options_menu: Control = $OptionsMenu
@onready var player_animation_player: AnimationPlayer = $PlayerAnimationPlayer

enum MainMenuState { MAIN_MENU, OPTIONS }

var current_state = MainMenuState.MAIN_MENU


func set_state(new_state):
	current_state = new_state
	match new_state:
		MainMenuState.MAIN_MENU:
			_show_main_menu()
		MainMenuState.OPTIONS:
			_show_options()


#func _process(_delta: float) -> void:
	#if current_state == MainMenuState.OPTIONS:
		#if Input.is_action_just_pressed("back"):
			#set_state(MainMenuState.MAIN_MENU)


func _input(event):
	if event.is_action_pressed("pause"):
		if current_state == MainMenuState.OPTIONS:
			set_state(MainMenuState.MAIN_MENU)
			return
		elif current_state == MainMenuState.MAIN_MENU:
			set_state(MainMenuState.OPTIONS)
			return


func _show_main_menu():
	button_v_box_container.visible = true
	options_menu.visible = false
	
	
func _show_options():
	button_v_box_container.visible = false
	options_menu.visible = true


func _on_start_game_button_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	start_game_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	options_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	exit_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	button_start_pressed.emit()


func _on_button_options_pressed() -> void:
	set_state(MainMenuState.OPTIONS)


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func animate_player_out():
	player_animation_player.play("player_transitions/player_transition_out")



func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true: set_mode_requested.emit(true)
	if toggled_on == false: set_mode_requested.emit(false)

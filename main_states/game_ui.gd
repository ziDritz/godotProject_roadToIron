## For now, also manage all clickable things on screen
class_name GameUI
extends CanvasLayer




signal retry_requested
signal main_menu_requested
signal end_turn_requested
signal spell_button_pressed
signal spell_button_2_pressed

@onready var pause_menu: OptionsMenu = $PauseMenu
@onready var game_over: GameOver = $GameOver
@onready var active_team_label: Label = $VBoxContainer/ActiveTeamLabel
@onready var turn_count_label: Label = $VBoxContainer/TurnCountLabel
@onready var spell_button: Button = $PanelContainer/HBoxContainer/VBoxContainer/SpellButton
@onready var spell_button_2: Button = $PanelContainer/HBoxContainer/VBoxContainer/SpellButton2




func set_pause(_bool: bool):
	pause_menu.visible = _bool
	
	
func set_game_over():
	game_over.visible = true


func _on_game_over_retry_button_pressed() -> void:
	retry_requested.emit()
	game_over.visible = false


func _on_game_over_main_menu_button_pressed() -> void:
	main_menu_requested.emit()
	game_over.visible = false


func _on_spell_button_pressed() -> void:
	spell_button_pressed.emit()


func _on_spell_button_2_pressed() -> void:
	spell_button_2_pressed.emit()


func _on_end_turn_button_pressed() -> void:
	print("_on_end_turn_button_pressed")
	end_turn_requested.emit()


func _on_turn_system_on_turn_start(character_team: Team, turn_count: int) -> void:
	turn_count_label.text = "Turn count: " + str(turn_count)
	active_team_label.text = "Active team: " + character_team.name


func _on_character_team_allies_ally_character_selected(character: Character) -> void:
	spell_button.text = character.spell_caster.spell_book[0]
	spell_button_2.text = character.spell_caster.spell_book[1]

class_name TurnSystem
extends Node




signal on_turn_start(character_team: Team, turn_count: int)
signal on_turn_end()

@export var team_turn_order: Array[Team] = []
var turn_order: Array[TurnCharacter] = []
var current_turn_index: int = 0
var turn_count: int = 0
var current_active_team: Team = null
var current_active_character: TurnCharacter = null




func _ready() -> void:
	for team in team_turn_order:
		team.set_init_state()
	
	current_active_team = team_turn_order[current_turn_index]
	current_active_team.set_select_ally_character_state()
	on_turn_start.emit(team_turn_order[current_turn_index], turn_count)


func end_team_turn() -> void:
	current_active_team.set_idle_state()
	on_turn_end.emit()
	_start_team_turn()


func end_character_turn() -> void:
	current_active_character.is_active = false
	current_turn_index += 1
	if current_turn_index >= turn_order.size():
		current_turn_index = 0


func _add_character(character: TurnCharacter) -> void:
	if character not in turn_order:
		turn_order.append(character)
		_set_turn_order()
		print(str(character.name) + " : added")


func _remove_character(character: TurnCharacter) -> void:
	if character in turn_order:
		var removed_index = turn_order.find(character)
		turn_order.erase(character)

		# Adjust turn index if needed
		if removed_index <= current_turn_index and current_turn_index > 0:
			current_turn_index -= 1

		if current_turn_index >= turn_order.size():
			current_turn_index = 0


func _set_turn_order() -> void:
	turn_order.sort_custom(_sort_by_initiative)

	print("Turn order :")
	for character in turn_order:
		print(character.get_parent().name)


func _start_team_turn() -> void:
	current_turn_index += 1
	if current_turn_index >= team_turn_order.size():
		current_turn_index = 0
		turn_count += 1
		
	current_active_team = team_turn_order[current_turn_index]
	current_active_team.set_select_ally_character_state()
	
	on_turn_start.emit(current_active_team, turn_count)
	print("turn count: " + str(turn_count))
	print("active team: " + current_active_team.name)
	print("Turned started")


func _sort_by_initiative(a: TurnCharacter, b: TurnCharacter) -> bool:
	var a_initiative = a.initiative
	var b_initiative = b.initiative
	return a_initiative > b_initiative


func _on_end_turn_button_pressed() -> void:
	end_team_turn()

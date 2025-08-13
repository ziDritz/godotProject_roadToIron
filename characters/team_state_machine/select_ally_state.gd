class_name SelectAllyState
extends TeamState


@onready var team = owner as Team


func enter(previous_state: String, data: Dictionary = {}):
	print("Entered SELECT_ALLY_CHARACTER state")

func handle_input(event: InputEvent):
	if event.is_action_pressed("click"):
		var character = team._get_character_under_mouse()
		if character:
			if team.selected_character == character:
				team.selected_character.is_selected = false
				team.selected_character = null
			else:
				if team.selected_character:
					team.selected_character.is_selected = false
				team.selected_character = character
				team.selected_character.is_selected = true
				team.ally_character_selected.emit(character)
				finished.emit("SelectSpellState")

func exit():
	pass

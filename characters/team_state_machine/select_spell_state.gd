class_name SelectSpellState
extends TeamState


@onready var team = owner as Team


func enter(previous_state: String, data: Dictionary = {}):
	print("Entered SELECT_SPELL state")

func handle_input(event: InputEvent):
	if event.is_action_pressed("spell_1"):
		team.selected_spell_id = team.selected_character.spell_caster.spell_book[0]
		finished.emit("SelectTargetState")
	if event.is_action_pressed("spell_2"):
		team.selected_spell_id = team.selected_character.spell_caster.spell_book[1]
		finished.emit("SelectTargetState")
	if event.is_action_pressed("click"):
		finished.emit("SelectAllyState")  # Allow reselection

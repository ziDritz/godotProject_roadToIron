class_name CastSpellState
extends TeamState


@onready var team = owner as Team


func enter(previous_state: String, data: Dictionary = {}):
	print("Entered CAST_SPELL state")
	team.selected_character.spell_caster.cast_spell(team.selected_spell_id, team.target)
	finished.emit("SelectAllyState")

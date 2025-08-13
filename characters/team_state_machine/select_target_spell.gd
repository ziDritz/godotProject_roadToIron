class_name SelectTargetState
extends TeamState


@onready var team = owner as Team


func enter(previous_state: String, data: Dictionary = {}):
	print("Entered SELECT_TARGET state")

func handle_input(event: InputEvent):
	if event.is_action_pressed("click"):
		var target = team._get_character_under_mouse()
		if target:
			team.target = target
			team.target_selected.emit(target)
			finished.emit("CastSpellState")

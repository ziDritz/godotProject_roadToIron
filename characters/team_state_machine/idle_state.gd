class_name IdleState
extends TeamState

@onready var team = owner as Team

func enter(previous_state: String, data: Dictionary = {}):
	print("Entered IDLE state")
	if team.selected_character:
		team.selected_character.is_selected = false
		team.selected_character = null

func handle_input(event: InputEvent):
	if event.is_action_pressed("click"):
		finished.emit("SelectAllyState")

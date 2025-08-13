class_name TeamStateMachine
extends Node


@export var initial_state: TeamState
var current_state: TeamState


func _ready():
	if initial_state != null:
		current_state = initial_state
	for state in get_children():
		state.finished.connect(_on_state_finished)
	current_state.enter("")

func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)

func _process(delta: float):
	current_state.update(delta)

func _on_state_finished(next_state_path: String):
	current_state.exit()
	current_state = get_node(next_state_path)
	current_state.enter(current_state.name)

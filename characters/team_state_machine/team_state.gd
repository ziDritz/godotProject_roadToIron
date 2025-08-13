class_name TeamState
extends Node


signal finished(next_state: String)


func enter(previous_state: String, data: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	pass

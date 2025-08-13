extends Node

func _ready() -> void:
	var char = $CharacterManager.get_character("Darius")
	char.position = Vector2(100, 100)
	char.reparent(self)

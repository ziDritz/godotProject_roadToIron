extends Label


func _on_health_changed(health: int, diff: int) -> void:
	text = "Life: " + str(health)

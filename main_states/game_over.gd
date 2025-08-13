class_name GameOver
extends Control

signal retry_button_pressed()
signal main_menu_button_pressed()


func _on_retry_button_pressed() -> void:
	retry_button_pressed.emit()


func _on_main_menu_button_pressed() -> void:
	main_menu_button_pressed.emit()

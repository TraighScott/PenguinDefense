extends Node2D


func _ready() -> void:
	SoundController.lose_sound()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

extends Node2D

func _ready() -> void:
	SoundController.game_music()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_controls_button_pressed() -> void:
	$ControlsBorder.visible = true


func _on_close_button_pressed() -> void:
	$ControlsBorder.visible = false

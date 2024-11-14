class_name Towers extends Node2D

signal changed_direction

func _on_world_changed_direction():
	print("class pass")
	changed_direction.emit()

extends StaticBody2D


func _ready() -> void:
	await get_tree().create_timer(.05).timeout
	queue_free()
